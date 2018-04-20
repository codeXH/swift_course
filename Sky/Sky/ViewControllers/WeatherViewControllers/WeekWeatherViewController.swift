//
//  WeekWeatherViewController.swift
//  Sky
//
//  Created by zhangjianyun on 2018/4/17.
//  Copyright © 2018年 Mars. All rights reserved.
//

import UIKit

class WeekWeatherViewController: WeatherViewController {

    @IBOutlet weak var weekWeatherTableView: UITableView!
    
    var viewModel: WeekWeatherViewModel? {
        didSet {
            DispatchQueue.main.async {
                self.updateView()
            }
        }
    }
    
    func updateView() {
        self.activityIndicatorView.stopAnimating()
        
        if viewModel != nil {
            self.updateWeatherContainer()
        }
        else {
            self.loadingFailedLabel.isHidden = false
            self.loadingFailedLabel.text = "Cannot load fetch weather/location data from the network."
        }
    }
    
    func updateWeatherContainer() {
        weatherContainerView.isHidden = false
        weekWeatherTableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension WeekWeatherViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.weatherData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: WeekWeatherTableViewCell = tableView.dequeueReusableCell(withIdentifier: WeekWeatherTableViewCell.reuseIdentifier) as! WeekWeatherTableViewCell
        if let weatherDay = viewModel?.viewModel(for: indexPath.row) {
            cell.configue(with: weatherDay)
        }
        return cell
    }
}

extension WeekWeatherViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 104
    }
}
