//
//  WeekWeatherDayViewModelTests.swift
//  SkyTests
//
//  Created by zhangjianyun on 2018/4/18.
//  Copyright © 2018年 Mars. All rights reserved.
//

import XCTest
@testable import Sky

class WeekWeatherDayViewModelTests: XCTestCase {
    var vm: WeekWeatherDayViewModel!
    override func setUp() {
        super.setUp()
        let data = loadDataFromBundle(
            ofname: "DarkSky", ext: "json")
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        let weatherData = try! decoder.decode(
            WeatherData.self, from: data)
        
        vm = WeekWeatherDayViewModel.init(weatherData: weatherData.daily.data[0])
        
    }
    
    override func tearDown() {
        super.tearDown()
        vm = nil
        UserDefaults.standard.removeObject(
            forKey: UserDefaultsKey.dataMode)
        UserDefaults.standard.removeObject(
            forKey: UserDefaultsKey.temperatureMode)
    }
    
    func test_date_display_in_text_mode() {
        let dateMode: DateMode = .text
        UserDefaults.standard.set(dateMode.rawValue, forKey: UserDefaultsKey.dataMode)
        XCTAssertEqual(vm.date, "十月 5")
    }
    func test_week_display_in_dight_mode() {
        let dateMode: DateMode = .dight
        UserDefaults.standard.set(dateMode.rawValue, forKey: UserDefaultsKey.dataMode)
        XCTAssertEqual(vm.week, "星期四")
    }
    func test_temperature_display_in_celsius_mode() {
        let temperatureMode: TemperatureMode = .celsius
        UserDefaults.standard.set(temperatureMode.rawValue, forKey: UserDefaultsKey.temperatureMode)
        XCTAssertEqual(vm.temperature, "19 °C ~ 28 °C")
    }
    func test_temperature_display_in_fahrenheit_mode() {
        let temperatureMode: TemperatureMode = .fahrenheit
        UserDefaults.standard.set(temperatureMode.rawValue, forKey: UserDefaultsKey.temperatureMode)
        XCTAssertEqual(vm.temperature, "66 °F ~ 82 °F")
    }
    func test_humpity_display() {
        XCTAssertEqual(vm.humidity, "25 %")
    }
    
    func test_weatherIcon_display() {
        
        let iconFromViewModel = UIImagePNGRepresentation(vm.weatherIcon!)
        let iconFromTestData = UIImagePNGRepresentation(UIImage.init(named: "clear-day")!)
        XCTAssertEqual(vm.weatherIcon!.size.width, 108.0)
        XCTAssertEqual(vm.weatherIcon!.size.height, 108.0)
        XCTAssertEqual(iconFromViewModel, iconFromTestData)
    }
}
