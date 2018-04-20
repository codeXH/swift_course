//
//  WeekWeatherTableViewCell.swift
//  Sky
//
//  Created by zhangjianyun on 2018/4/17.
//  Copyright © 2018年 Mars. All rights reserved.
//

import UIKit

class WeekWeatherTableViewCell: UITableViewCell {
    static let reuseIdentifier = "WeekWeatherCell"
    @IBOutlet weak var week: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var humid: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configue(with viewModel: WeekWeatherDayRepresentable) {
        self.week.text = viewModel.week
        self.date.text = viewModel.date
        self.temperature.text = viewModel.temperature
        self.weatherIcon.image = viewModel.weatherIcon
        self.humid.text = viewModel.humidity
    }

}
