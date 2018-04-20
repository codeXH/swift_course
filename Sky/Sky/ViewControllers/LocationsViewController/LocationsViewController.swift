//
//  LocationsViewController.swift
//  Sky
//
//  Created by zhangjianyun on 2018/4/19.
//  Copyright © 2018年 Mars. All rights reserved.
//

import UIKit
import CoreLocation

protocol LocationsViewControllerDelegate {
    func controller(_ controller: LocationsViewController, didSelectLocation location: CLLocation)
}

class LocationsViewController: UITableViewController {

    var currentLocations: CLLocation?
    var favourites = UserDefaults.loadLocations()
    var delegate: LocationsViewControllerDelegate?
    private var hasFavourites: Bool {
        return favourites.count>0
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return Section.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else {
            fatalError("Unexpected Section")
        }
        switch section {
        case .current:
            return 1
        case .favourite:
            return max(favourites.count, 0)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = Section(rawValue: section) else {
            fatalError("Unexpected Section")
        }
        return section.title
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else {
            fatalError("Unexpected Section")
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier:LocationTableViewCell.reuseIdentifier, for: indexPath) as? LocationTableViewCell else {
            fatalError("Unexpected Section")
        }
        
        var vm: LocationsViewModel?
        
        switch section {
        case .current:
            if let currentLocation = currentLocations {
                vm = LocationsViewModel(location: currentLocation, locationText: nil)
            }
            else {
                cell.label.text = "Current Location Unknown"
            }
        case .favourite:
            if favourites.count > 0 {
                let fav = favourites[indexPath.row]
                vm = LocationsViewModel(location: fav.location, locationText: fav.name)
            }
            else {
                cell.label.text = "No Favourites Yet..."
            }
        }
        
        if let vm = vm {
            cell.configue(of: vm)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        guard let section = Section(rawValue: indexPath.section) else {
            fatalError("")
        }
        switch section {
        case .current:
            return false
        case .favourite:
            return hasFavourites
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let location = favourites[indexPath.row]
        UserDefaults.removeLocation(location)
        
        favourites.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = Section(rawValue: indexPath.section) else {
            fatalError("")
        }
        
        var location: CLLocation?
        
        switch section {
        case .current:
            if let currentLocation = currentLocations{
                location = currentLocation
            }
        case .favourite:
            if hasFavourites {
                location = favourites[indexPath.row].location
            }
        }
        
        if location != nil {
            delegate?.controller(self, didSelectLocation: location!)
            dismiss(animated: true)
        }
    }
    
    @IBAction func unwindToLocationViewController(segue: UIStoryboardSegue) {
        
    }
    
    var settingViewController: SettingsViewController!
    
    private let segueCurrentWeather = "SegueCurrentWeather"
    var addLocationViewController: AddLocationViewController!
    
    private var segueAddLocations = "SegueAddLocations"
    
    // navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return}
        switch identifier {
        case segueAddLocations:
            guard let destination = segue.destination as? AddLocationViewController else {
                fatalError("Invalid destination view controller!")
            }
            destination.delegate = self
            addLocationViewController = destination
        default:
            break
        }
    }
}

extension LocationsViewController {
    private enum Section: Int {
        case current
        case favourite
        
        var title: String {
            switch self {
            case .current:
                return "Current Location"
            case .favourite:
                return "Favourite Locations"
            }
        }
        static var count: Int {
            return Section.favourite.rawValue + 1
        }
    }
}

extension LocationsViewController: AddLocationViewControllerDelegate {
    func controller(_ controller: AddLocationViewController, location: Location) {
        UserDefaults.addLocation(location)
        favourites.append(location)
        self.tableView.reloadData()
    }
}






