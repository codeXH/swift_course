//
//  ViewController.swift
//  Sky
//
//  Created by Mars on 28/09/2017.
//  Copyright © 2017 Mars. All rights reserved.
//

import UIKit
import CoreLocation

class RootViewController: UIViewController {
    
    private var currentLocation: CLLocation? {
        didSet {
            //fetch the city name
            self.fetchCity()
            //fetch the weather data
            self.fetchWeatherData()
        }
    }
    
    var currentWeatherViewController: CurrentWeatherViewController!
    var weekWeatherViewController: WeekWeatherViewController!
    var settingViewController: SettingsViewController!
    
    private let segueCurrentWeather = "SegueCurrentWeather"
    private let segueWeekWeather = "SegueWeekWeather"
    private let segueSettings = "SegueSettings"
    private let segueLocations = "segueLocations"
    
    
    @IBAction func unwindToRootViewController(segue: UIStoryboardSegue) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return}
        
        switch identifier {
        case segueCurrentWeather:
            guard let destination = segue.destination as? CurrentWeatherViewController else {
                fatalError("Invalid destination view controller!")
            }
            destination.delegate = self
            destination.viewModel = CurrentWeatherViewModel()
            currentWeatherViewController = destination
            
        case segueWeekWeather:
            guard let destination = segue.destination as? WeekWeatherViewController else {
                fatalError("Invalid destination view controller!")
            }
            destination.viewModel = WeekWeatherViewModel(weatherData: [])
            weekWeatherViewController = destination
            
        case segueSettings:
            guard let navigationController = segue.destination as? UINavigationController else {
                fatalError("Invalid destination view controller!")
            }
            guard let destination = navigationController.topViewController as? SettingsViewController else {
                fatalError("Invalid destination view controller!")
            }
            destination.delegate = self
            settingViewController = destination
            
        case segueLocations:
            guard let navigationController = segue.destination as? UINavigationController else {
                fatalError("Invalid destination view controller!")
            }
            guard let destination = navigationController.topViewController as? LocationsViewController else {
                fatalError("Invalid destination view controller!")
            }
            destination.delegate = self
            destination.currentLocations = currentLocation
            
        default:
            break
        }
    }
    
    private func fetchCity() {
        guard let currentLocation = currentLocation else { return }
        
        CLGeocoder().reverseGeocodeLocation(currentLocation) { (placemarks, error) in
            if let error = error {
                dump(error)
            }
            else if let city = placemarks?.first?.locality {
                //notification the Container
                let location = Location(name: city, latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
                self.currentWeatherViewController.viewModel?.location = location
            }
        }
    }
    
    private func fetchWeatherData() {
        guard let currentLocation = currentLocation else { return }
        
        let lat = currentLocation.coordinate.latitude
        let log = currentLocation.coordinate.longitude
        
        WeatherDataManager.shared.weatherDataAt(latitude: lat, longtitude: log) { (response, error) in
            if let error = error {
                dump(error)
            }
            else if let response = response {
                //notification the CurrentWeatherViewController
                self.currentWeatherViewController.viewModel?.weather = response
                self.weekWeatherViewController.viewModel = WeekWeatherViewModel(weatherData: response.daily.data)
            }
        }
        
    }
    
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.distanceFilter = 1000
        manager.desiredAccuracy = 1000
        return manager
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupActiveNotification()
    }
    
    @objc func applicationDidBecomeActive(notification: Notification) {
        
        locationManager.delegate = self
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
        else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    
    private func setupActiveNotification() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive(notification:)), name: Notification.Name.UIApplicationDidBecomeActive, object: nil)
    }
}

// MARK: LocationDelegate
extension RootViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            currentLocation = location
            locationManager.delegate = nil
            locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        dump(error)
    }
}

// MARK: WeatherViewControllerDelegate
extension RootViewController: CurrentWeatherViewControllerDelegate {
    
    func locationButtonPressed(controller: CurrentWeatherViewController) {
        performSegue(withIdentifier: segueLocations, sender: self)
    }
    
    func settingsButtonPressed(controller: CurrentWeatherViewController) {
        performSegue(withIdentifier: segueSettings, sender: self)
    }
}

// MARK: SettingViewControllerDelegate
extension RootViewController: SettingsViewControllerDelegate {
    
    func controllerDidChangeTimeMode(controller: SettingsViewController) {
        self.reloadUI()
    }
    
    func controllerDidChangeTempuratureMode(controller: SettingsViewController) {
        self.reloadUI()
    }
    
    func reloadUI() {
        self.currentWeatherViewController.updateView()
        self.weekWeatherViewController.updateView()
    }
}

// MARK: LocationsViewControllerDelegate
extension RootViewController: LocationsViewControllerDelegate {
    
    func controller(_ controller: LocationsViewController, didSelectLocation location: CLLocation) {
        currentLocation = location
    }
}
