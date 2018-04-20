//
//  UserDefaults.swift
//  Sky
//
//  Created by zhangjianyun on 2018/4/18.
//  Copyright © 2018年 Mars. All rights reserved.
//

import Foundation

enum DateMode: Int {
    case text
    case dight
    
    var formot: String {
        return self == .text ? "E, dd MMMM" : "EEEEE, MM/dd"
    }
}

enum TemperatureMode: Int {
    case celsius
    case fahrenheit
}

struct UserDefaultsKey {
    static let dataMode = "dataMode"
    static let temperatureMode = "tempetatureMode"
    static let locations = "locations"
}

extension UserDefaults {
    static func dateMode() -> DateMode {
        let value = UserDefaults.standard.integer(forKey: UserDefaultsKey.dataMode)
        return DateMode(rawValue: value) ?? DateMode.text
    }
    
    static func setDateMode(to value: DateMode) {
        UserDefaults.standard.set(value.rawValue, forKey: UserDefaultsKey.dataMode)
    }
    
    static func temperatureMode() -> TemperatureMode {
        let value = UserDefaults.standard.integer(forKey: UserDefaultsKey.temperatureMode)
        return TemperatureMode(rawValue: value) ?? TemperatureMode.celsius
    }
    
    static func setTemperatureMode(to value: TemperatureMode) {
        UserDefaults.standard.set(value.rawValue, forKey: UserDefaultsKey.temperatureMode)
    }
    
    // Locations
    
    static func saveLocations (_ locations: [Location]) {
        let dictionaries: [[String: Any]] = locations.map { $0.toDictionary }
        UserDefaults.standard.set(dictionaries, forKey: UserDefaultsKey.locations)
    }
    
    static func loadLocations() -> [Location]{
        let data = UserDefaults.standard.array(forKey: UserDefaultsKey.locations)
        guard let dictionaries = data as? [[String: Any]] else {
            return []
        }
        return dictionaries.compactMap {
            return Location(form: $0)
        }
    }
    
    static func addLocation(_ location: Location) {
        var locations = loadLocations()
        locations.append(location)
        saveLocations(locations)
    }
    
    static func removeLocation(_ location: Location) {
        var locations = loadLocations()
        guard let index = locations.index(of: location) else {
            return
        }
        locations.remove(at: index)
        saveLocations(locations)
    }
}







