//
//  LocationsViewModel.swift
//  Sky
//
//  Created by zhangjianyun on 2018/4/19.
//  Copyright © 2018年 Mars. All rights reserved.
//

import Foundation
import CoreLocation

struct LocationsViewModel {
    let location: CLLocation?
    let locationText: String?
    
}

extension LocationsViewModel: LocationRepresentable {
    var labelText: String {
        if let locationText = locationText {
            return locationText
        }
        else if let location = location {
            return location.toString
        }
        return "Unknown position"
    }
}
