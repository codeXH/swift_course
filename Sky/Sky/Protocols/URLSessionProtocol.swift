//
//  URLSessionProtocol.swift
//  Sky
//
//  Created by zhangjianyun on 2018/4/16.
//  Copyright © 2018年 Mars. All rights reserved.
//

import Foundation

typealias DataTaskHandler = (Data?,URLResponse?,Error?) -> Void
protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskHandler) -> URLSessionDataTaskProtocol
}
