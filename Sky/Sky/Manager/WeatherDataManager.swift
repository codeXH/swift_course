//
//  WeatherDataManager.swift
//  Sky
//
//  Created by zhangjianyun on 2018/4/16.
//  Copyright © 2018年 Mars. All rights reserved.
//

import Foundation

internal class DarkSkyURLSession: URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskHandler) -> URLSessionDataTaskProtocol {
        return DarkSkyURLSessionDataTask.init(request: request, completion: completionHandler)
    }
}

internal class DarkSkyURLSessionDataTask: URLSessionDataTaskProtocol {
    
    private let request: URLRequest
    private let completion: DataTaskHandler
    
    init(request: URLRequest, completion: @escaping DataTaskHandler) {
        self.request = request
        self.completion = completion
    }
    
    func resume() {
        
        let josn = ProcessInfo.processInfo.environment["FakeJSON"]
        if let json = josn {
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)
            let data = json.data(using: String.Encoding.utf8)!
            
            completion(data,response,nil)
            
        }
    }
}

internal struct Config {
    private static func isTesting() -> Bool {
        return ProcessInfo.processInfo.arguments.contains("UI-TESTING")
    }
    
    static var urlSession: URLSessionProtocol = {
        if isTesting() {
            return DarkSkyURLSession()
        }
        else {
            return URLSession.shared
        }
    }()
}

enum DataManageError: Error {
    case failedRequest
    case invalidResponse
    case unknown
}

final class WeatherDataManager {
    
    internal let baseURL: URL
    internal let urlSession: URLSessionProtocol
    internal init(baseURL: URL, urlSession: URLSessionProtocol) {
        self.baseURL = baseURL
        self.urlSession = urlSession
    }
    
    static let shared = WeatherDataManager.init(baseURL: API.authenicatedURL, urlSession: Config.urlSession)
    
    typealias CompletionHandler = (WeatherData?,DataManageError?) -> Void
    
    func weatherDataAt(
        latitude: Double,
        longtitude: Double,
        completion: @escaping CompletionHandler) {
        //1.connection the url
        let url = baseURL.appendingPathComponent("\(latitude),\(longtitude)")
        var request = URLRequest.init(url: url)
        
        //2. set http header
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        //3. lunch the request
        self.urlSession.dataTask(with: request) { (data, response, error) in
            //4. get the response here
            self.didFinishGettingWeatherData(data: data, response: response, error: error, complication: completion)
        }.resume()
    }
    
    func didFinishGettingWeatherData(
        data: Data?,
        response: URLResponse?,
        error: Error?,
        complication: CompletionHandler) {
        
        if error != nil {
            complication(nil, .failedRequest)
        }
        else if let data = data,
            let response = response as? HTTPURLResponse {
            if response.statusCode == 200 {
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .secondsSince1970
                    let weatherData = try decoder.decode(WeatherData.self, from: data)
                    complication(weatherData,nil)
                }
                catch {
                    complication(nil, .invalidResponse)
                }
            }
            else {
                complication(nil, .failedRequest)
            }
        }
        else {
            complication(nil, .unknown)
        }
    }
}
