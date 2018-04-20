//
//  WeatherDataManagerTest.swift
//  SkyTests
//
//  Created by zhangjianyun on 2018/4/16.
//  Copyright © 2018年 Mars. All rights reserved.
//

import XCTest
@testable import Sky

class WeatherDataManagerTest: XCTestCase {
    
    let url = URL.init(string: "https://darksky.net")!
    var session: MockURLSession!
    var manager: WeatherDataManager!
    
    override func setUp() {
        super.setUp()
        self.session = MockURLSession()
        self.manager = WeatherDataManager.init(baseURL: url, urlSession: session)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_weatherDataAt_start_the_session() {
        
        let dataTask = MockURLSessionDataTask()
        
        session.sessionDataTask = dataTask
        
        manager.weatherDataAt(latitude: 52, longtitude: 100) { (_, _) in }
        XCTAssert(session.sessionDataTask.isResumeCalled)

    }
    
    func test_weatherDataAt_get_data() {
        
        let expect = expectation(description: "Loading data from \(API.authenicatedURL)")
        
        var data: WeatherData? = nil
        WeatherDataManager.shared.weatherDataAt(latitude: 52, longtitude: 100) { (response, error) in
            data = response
            expect.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(data)
    }
    
    func test_weatherDataAt_handle_invalid_request() {
        
        session.responseError = NSError.init(
            domain: "Invalid Request",
            code: 100,
            userInfo: nil
        )
        
        var error: DataManageError? = nil
        manager.weatherDataAt(latitude: 52, longtitude: 100) { (_, e) in
            error = e
        }
        XCTAssertEqual(error, DataManageError.failedRequest)
    }
    
    func test_weatherDataAt_handle_statuscode_not_equal_to_200() {
        
        session.responseHeader = HTTPURLResponse(
            url: url, statusCode: 400, httpVersion: nil, headerFields: nil
        )
        
        let data = "{}".data(using: String.Encoding.utf8)!
        session.responseData = data
        
        var error: DataManageError? = nil
        
        manager.weatherDataAt(latitude: 52, longtitude: 100) { (_, e) in
            error = e
        }
        XCTAssertEqual(error, DataManageError.failedRequest)
    }
    
    func test_weatherDataAt_handle_invalid_response() {
        
        session.responseHeader = HTTPURLResponse.init(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let data = "{".data(using: String.Encoding.utf8)!
        session.responseData = data
        
        var error: DataManageError? = nil
        
        manager.weatherDataAt(latitude: 52, longtitude: 100) { (_, e) in
            error = e
        }
        XCTAssertEqual(error, DataManageError.invalidResponse)
    }
    
    func test_weatherDataAt_handle_response_decode() {
        
        session.responseHeader = HTTPURLResponse.init(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let data = """
        {
        "longitude" : 100,
        "latitude" : 52,
        "currently" : {
            "temperature" : 23,
            "humidity" : 0.91,
            "icon" : "snow",
            "time" : 1507180335,
            "summary" : "Light Snow"
            },
        "daily": {
            "data": [
                {
                    "time": 1507180335,
                    "icon": "clear-day",
                    "temperatureLow": 66,
                    "temperatureHigh": 82,
                    "humidity": 0.25
                }
            ]
        }
        }
        """.data(using: String.Encoding.utf8)!
        session.responseData = data
        
        var decode: WeatherData? = nil
        
        manager.weatherDataAt(latitude: 52, longtitude: 100) { (d, _) in
            decode = d
        }
        
        let expectedWeekData = WeatherData.WeekWeatherData(data: [
            ForecastData(
                time: Date(timeIntervalSince1970: 1507180335),
                temperatureLow: 66,
                temperatureHigh: 82,
                icon: "clear-day",
                humidity: 0.25)
            ])
        let expected = WeatherData(
            latitude: 52,
            longitude: 100,
            currently: WeatherData.CurrentWeather(
                time: Date(timeIntervalSince1970: 1507180335),
                summary: "Light Snow",
                icon: "snow",
                temperature: 23,
                humidity: 0.91),
            daily: expectedWeekData)
        
        XCTAssertEqual(decode, expected)
        
    }
}



























