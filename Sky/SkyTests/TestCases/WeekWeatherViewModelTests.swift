//
//  WeekWeatherViewModelTests.swift
//  SkyTests
//
//  Created by zhangjianyun on 2018/4/18.
//  Copyright © 2018年 Mars. All rights reserved.
//

import XCTest
@testable import Sky

class WeekWeatherViewModelTests: XCTestCase {
    
    var vm: WeekWeatherViewModel!
    
    override func setUp() {
        super.setUp()
        
        let data = loadDataFromBundle(
            ofname: "DarkSky", ext: "json")
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        let weatherData = try! decoder.decode(
            WeatherData.self, from: data)
        
        vm = WeekWeatherViewModel.init(weatherData: weatherData.daily.data)
    }
    
    override func tearDown() {
        super.tearDown()
        vm = nil
    }
  
    func test_numbers_of_sections() {
        XCTAssertEqual(vm.numberOfSections, 1)
    }
    
    func test_numbers_of_days() {
        XCTAssertEqual(vm.numberOfDays, 1)
    }
    
    func test_view_model_for_index() {
        let viewModel = vm.viewModel(for: 0)
        
        XCTAssertEqual(viewModel.date, "十月 5")
        XCTAssertEqual(viewModel.week, "星期四")
    }
}
