//
//  SettingsTemperatureViewModelTests.swift
//  SkyTests
//
//  Created by zhangjianyun on 2018/4/18.
//  Copyright © 2018年 Mars. All rights reserved.
//

import XCTest
@testable import Sky

class SettingsTemperatureViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.temperatureMode)
    }
    
    func test_date_display_in_celsius_mode() {
        let vm = SettingsTemperatureViewModel.init(temperatureMode: .celsius)
        XCTAssertEqual("Celsius", vm.labelText)
    }
    
    func test_date_display_in_fahrenhait_mode() {
        let vm = SettingsTemperatureViewModel.init(temperatureMode: .fahrenheit)
        XCTAssertEqual("Fahrenhait", vm.labelText)
    }
    
    func test_celsius_mode_selected() {
        let tempuratureMode: TemperatureMode = .celsius
        UserDefaults.standard.set(tempuratureMode.rawValue, forKey: UserDefaultsKey.temperatureMode)
        
        let vm = SettingsTemperatureViewModel.init(temperatureMode: tempuratureMode)
        XCTAssertEqual(vm.accessory,UITableViewCellAccessoryType.checkmark)
    }
    
    func test_celsius_mode_unselected() {
        let tempuratureMode: TemperatureMode = .celsius
        UserDefaults.standard.set(tempuratureMode.rawValue, forKey: UserDefaultsKey.temperatureMode)
        
        let vm = SettingsTemperatureViewModel.init(temperatureMode: .fahrenheit)
        XCTAssertEqual(vm.accessory,UITableViewCellAccessoryType.none)
    }
    
    func test_fahrenheit_mode_selected() {
        let tempuratureMode: TemperatureMode = .fahrenheit
        UserDefaults.standard.set(tempuratureMode.rawValue, forKey: UserDefaultsKey.temperatureMode)
        
        let vm = SettingsTemperatureViewModel.init(temperatureMode: .fahrenheit)
        XCTAssertEqual(vm.accessory, UITableViewCellAccessoryType.checkmark)
    }
    
    func test_fahrenheit_mode_unselected() {
        let tempuratureMode: TemperatureMode = .fahrenheit
        UserDefaults.standard.set(tempuratureMode.rawValue, forKey: UserDefaultsKey.temperatureMode)
        
        let vm = SettingsTemperatureViewModel.init(temperatureMode: .celsius)
        XCTAssertEqual(vm.accessory, UITableViewCellAccessoryType.none)
    }
}







