//
//  MockURLSession.swift
//  SkyTests
//
//  Created by zhangjianyun on 2018/4/16.
//  Copyright © 2018年 Mars. All rights reserved.
//

import Foundation
@testable import Sky

class MockURLSession: URLSessionProtocol {
    
    var responseData: Data?
    var responseHeader: HTTPURLResponse?
    var responseError: Error?
    var sessionDataTask = MockURLSessionDataTask()
    
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskHandler) -> URLSessionDataTaskProtocol {
        completionHandler(responseData, responseHeader, responseError)
        return sessionDataTask
    }
}
