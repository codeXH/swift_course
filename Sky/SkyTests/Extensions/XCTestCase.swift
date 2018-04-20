//
//  File.swift
//  SkyTests
//
//  Created by zhangjianyun on 2018/4/18.
//  Copyright © 2018年 Mars. All rights reserved.
//

import XCTest

extension XCTestCase {
    
    func loadDataFromBundle(ofname name: String, ext: String) -> Data {
        let principleClass = type(of: self)
        let bundle = Bundle.init(for: principleClass)
        let url = bundle.url(forResource: name, withExtension: ext)
        
        return try! Data(contentsOf: url!)
    }
}
