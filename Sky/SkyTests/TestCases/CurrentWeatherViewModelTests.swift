//
//  CurrentWeatherViewModelTests.swift
//  SkyTests
//
//  Created by zhangjianyun on 2018/4/18.
//  Copyright © 2018年 Mars. All rights reserved.
//

import XCTest
@testable import Sky

class CurrentWeatherViewModelTests: XCTestCase {
    var vm: CurrentWeatherViewModel!
    override func setUp() {
        super.setUp()
        // 1.load data
        let data = loadDataFromBundle(ofname: "DarkSky", ext: "json")
        
        // 2.decode data
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        let weatherData = try! decoder.decode(WeatherData.self, from: data)
        
        // 3. create the view model
        vm = CurrentWeatherViewModel()
        vm.location = Location.init(name: "Test City", latitude: 100, longitude: 100)
        vm.weather = weatherData
    }
    
    override func tearDown() {
        super.tearDown()
        vm = nil
        UserDefaults.standard.removeObject(
            forKey: UserDefaultsKey.dataMode)
        UserDefaults.standard.removeObject(
            forKey: UserDefaultsKey.temperatureMode)
    }
    
    func test_city_name_display() {
        XCTAssertEqual(vm.city, "Test City")
    }
    func test_weather_summry() {
        XCTAssertEqual(vm.summary, "Light Snow")
    }
    func test_humidity_display() {
        XCTAssertEqual(vm.humidity, "91.0 %")
    }
    func test_date_display_in_text_mode() {
        let dateMode: DateMode = .text
        UserDefaults.standard.set(dateMode.rawValue, forKey: UserDefaultsKey.dataMode)
        XCTAssertEqual(vm.date, "周四, 05 十月")
    }
    func test_date_display_in_dight_mode() {
        let dateMode: DateMode = .dight
        UserDefaults.standard.set(dateMode.rawValue, forKey: UserDefaultsKey.dataMode)
        XCTAssertEqual(vm.date, "四, 10/05")
    }
    func test_temperature_display_in_celsius_mode() {
        let temperatureMode: TemperatureMode = .celsius
        UserDefaults.standard.set(temperatureMode.rawValue, forKey: UserDefaultsKey.temperatureMode)
        XCTAssertEqual(vm.temperature, "-5.0 °C")
    }
    func test_temperature_display_in_fahrenheit_mode() {
        let temperatureMode: TemperatureMode = .fahrenheit
        UserDefaults.standard.set(temperatureMode.rawValue, forKey: UserDefaultsKey.temperatureMode)
        XCTAssertEqual(vm.temperature, "23.0 °F")
    }
    func test_weatherIcon_display() {
        let iconFromViewModel = UIImagePNGRepresentation(vm.weatherIcon)
        let iconFromTestData = UIImagePNGRepresentation(UIImage.init(named: "snow")!)
        XCTAssertEqual(vm.weatherIcon.size.width, 116.0)
        XCTAssertEqual(vm.weatherIcon.size.height, 108.0)
        XCTAssertEqual(iconFromViewModel, iconFromTestData)
    }
}








