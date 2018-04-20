//
//  CLLocation.swift
//  Sky
//
//  Created by zhangjianyun on 2018/4/19.
//  Copyright © 2018年 Mars. All rights reserved.
//

import Foundation
import CoreLocation

extension CLLocation {
    var toString: String {
        let latitude =  String(format: "%.3f", coordinate.latitude)
        let longitude =  String(format: "%.3f", coordinate.longitude)
        
        return "\(latitude), \(longitude)"
    }
}
