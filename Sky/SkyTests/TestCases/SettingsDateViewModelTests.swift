//
//  SettingsDateViewModelTests.swift
//  SkyTests
//
//  Created by zhangjianyun on 2018/4/18.
//  Copyright © 2018年 Mars. All rights reserved.
//

import XCTest
@testable import Sky

class SettingsDateViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.dataMode)
    }
    
    func test_data_display_in_text_mode() {
        let vm = SettingsDateViewModel.init(dateMode: .text)
        XCTAssertEqual(vm.labelText, "Fri, 01 December")
    }
    
    func test_data_display_in_dight_mode() {
        let vm = SettingsDateViewModel.init(dateMode: .dight)
        XCTAssertEqual(vm.labelText, "F, 12/01")
    }
    
    func test_text_data_mode_selected() {
        let dateMode: DateMode = .text
        UserDefaults.standard.set(dateMode.rawValue, forKey: UserDefaultsKey.dataMode)
        
        let vm = SettingsDateViewModel.init(dateMode: dateMode)
        XCTAssertEqual(vm.accessory, UITableViewCellAccessoryType.checkmark)
    }
    
    func test_text_data_mode_unselected() {
        let dateMode: DateMode = .text
        UserDefaults.standard.set(dateMode.rawValue, forKey: UserDefaultsKey.dataMode)
        
        let vm = SettingsDateViewModel.init(dateMode: .dight)
        XCTAssertEqual(vm.accessory, UITableViewCellAccessoryType.none)
    }
    
    func test_dight_date_mode_selected() {
        let dateMode: DateMode = .dight
        UserDefaults.standard.set(dateMode.rawValue, forKey: UserDefaultsKey.dataMode)
        
        let vm = SettingsDateViewModel.init(dateMode: dateMode)
        XCTAssertEqual(vm.accessory, UITableViewCellAccessoryType.checkmark)
    }
    
    func test_dight_date_mode_unselected() {
        let dateMode: DateMode = .dight
        UserDefaults.standard.set(dateMode.rawValue, forKey: UserDefaultsKey.dataMode)
        
        let vm = SettingsDateViewModel.init(dateMode: .text)
        XCTAssertEqual(vm.accessory, UITableViewCellAccessoryType.none)
    }
}
