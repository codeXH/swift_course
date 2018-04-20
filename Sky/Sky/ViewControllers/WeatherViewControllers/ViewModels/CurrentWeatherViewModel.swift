//
//  CurrentWeatherViewModel.swift
//  Sky
//
//  Created by zhangjianyun on 2018/4/17.
//  Copyright © 2018年 Mars. All rights reserved.
//

import UIKit

struct CurrentWeatherViewModel {
    
    var isLocationReady = false
    var isWeatherReady = false
    var isUpdateReady: Bool {
        return isLocationReady && isWeatherReady
    }
    
    
    var location: Location! {
        didSet {
            if location != nil {
                self.isLocationReady = true
            }
            else {
                self.isLocationReady = false
            }
        }
    }
    
    var weather: WeatherData! {
        didSet {
            if weather != nil {
                self.isWeatherReady = true
            }
            else {
                self.isWeatherReady = false
            }
        }
    }

    
    var city: String {
        return location.name
    }
    
    var temperature: String {
        
        let value = weather.currently.temperature
        switch UserDefaults.temperatureMode() {
        case .celsius:
            return String(format: "%.1f °C", value.toCelcius())
        case .fahrenheit:
            return String(format: "%.1f °F", value)
        }
    }
    
    var weatherIcon: UIImage {
        return UIImage.weatherIcon(of: weather.currently.icon)!
    }
    
    var humidity: String {
        return String(format: "%.1f %%", weather.currently.humidity * 100)
    }
    
    var summary: String {
        return weather.currently.summary
    }
    
    var date: String {
        let formatter = DateFormatter()
        formatter.dateFormat = UserDefaults.dateMode().formot
        return formatter.string(from: weather.currently.time)
    }
}




