//
//  Image.swift
//  Sky
//
//  Created by zhangjianyun on 2018/4/17.
//  Copyright © 2018年 Mars. All rights reserved.
//

import UIKit

extension UIImage {
    
    class func weatherIcon(of name: String) -> UIImage? {
        
        switch name {
        case "clear-day":
            return UIImage.init(named: "clear-day")
        case "clear-night":
            return UIImage.init(named: "clear-night")
        case "rain":
            return UIImage.init(named: "rain")
        case "snow":
            return UIImage.init(named: "snow")
        case "sleet":
            return UIImage.init(named: "sleet")
        case "wind":
            return UIImage.init(named: "wind")
        case "cloudy":
            return UIImage.init(named: "cloudy")
        case "partly-cloudy-day":
            return UIImage.init(named: "partly-cloudy-day")
        case "partly-cloudy-night":
            return UIImage.init(named: "partly-cloudy-night")
        default:
            return UIImage.init(named: "clear-day")
        }
    }
}

