//
//  Confuguration.swift
//  Sky
//
//  Created by zhangjianyun on 2018/4/16.
//  Copyright © 2018年 Mars. All rights reserved.
//

import Foundation

struct API {
    
    static let key = "d4034157d035eb508b1d39a075f01bcb"
    static var baseURL = URL.init(string: "https://api.darksky.net/forecast/")!
    static let authenicatedURL = baseURL.appendingPathComponent(key)
}
