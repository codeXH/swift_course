//
//  Location.swift
//  Sky
//
//  Created by zhangjianyun on 2018/4/16.
//  Copyright © 2018年 Mars. All rights reserved.
//

import Foundation
import CoreLocation

struct Location: Equatable {
    
    var name: String
    var latitude: Double
    var longitude: Double
    
    
    private struct keys {
        static let name = "name"
        static let latitude = "latitude"
        static let longitude = "longitude"
    }
    
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
    
    init?(form dictionary: [String : Any]) {
        guard let name = dictionary[keys.name] as? String else {
            return nil
        }
        guard let latitute = dictionary[keys.latitude] as? Double else {
            return nil
        }
        guard let longitude = dictionary[keys.longitude] as? Double else {
            return nil
        }
        self .init(name: name, latitude: latitute, longitude: longitude)
    }
    
    var location: CLLocation {
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    var toDictionary: [String: Any] {
        
        return [
            "name": name,
            "latitude": latitude,
            "longitude": longitude
        ]
    }
    
}




