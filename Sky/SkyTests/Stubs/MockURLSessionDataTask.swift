//
//  MockURLSessionDataTask.swift
//  SkyTests
//
//  Created by zhangjianyun on 2018/4/16.
//  Copyright © 2018年 Mars. All rights reserved.
//

import Foundation
@testable import Sky

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    
    private (set) var isResumeCalled = false
    func resume() {
        self.isResumeCalled = true
    }
}
