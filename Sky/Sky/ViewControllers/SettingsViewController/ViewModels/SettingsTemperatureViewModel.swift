//
//  SettingsTemperatureViewModel.swift
//  Sky
//
//  Created by zhangjianyun on 2018/4/18.
//  Copyright © 2018年 Mars. All rights reserved.
//

import UIKit

struct SettingsTemperatureViewModel: SettingsRepresentable {
    let temperatureMode: TemperatureMode
    
    var labelText: String {
        return temperatureMode == .celsius ? "Celsius" : "Fahrenhait"
    }
    
    var accessory: UITableViewCellAccessoryType {
        if UserDefaults.temperatureMode() == temperatureMode {
            return .checkmark
        }
        else {
            return .none
        }
    }
}
