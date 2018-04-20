//
//  WeekWeatherViewModel.swift
//  Sky
//
//  Created by zhangjianyun on 2018/4/17.
//  Copyright © 2018年 Mars. All rights reserved.
//

import UIKit

struct WeekWeatherViewModel {
    
    let weatherData: [ForecastData]
    
    func viewModel(for index: Int) -> WeekWeatherDayViewModel {
        return WeekWeatherDayViewModel(weatherData: weatherData[index])
    }
    
    var numberOfSections: Int {
        return 1
    }
    
    var numberOfDays: Int {
        return weatherData.count
    }
    
}


