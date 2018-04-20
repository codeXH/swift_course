//
//  AddLocationViewModel.swift
//  Sky
//
//  Created by zhangjianyun on 2018/4/20.
//  Copyright © 2018年 Mars. All rights reserved.
//

import Foundation
import CoreLocation

class AddLocationViewModel {
    
    var queryText: String = "" {
        didSet {
            geocode(address: queryText)
        }
    }
    
    private lazy var geocoder = CLGeocoder()
    private func geocode(address: String?) {
        
        guard let address = address else {
            locations = []
            return
        }
        
        isQuerying = true
        geocoder.geocodeAddressString(address) {
            [weak self] (placemarks, error) in
            DispatchQueue.main.async {
                self?.processResponse(with: placemarks, error: error)
            }
        }
    }
    
    private func processResponse(with placemarks: [CLPlacemark]?, error: Error?) {
        
        isQuerying = false
        var locs: [Location] = []
        
        if let error = error {
            print("Cannot handle Geocode Address! \(error)")
        }
        else if let results = placemarks {
            locs = results.compactMap {
                result -> Location? in
                guard let name = result.name else { return nil }
                guard let location = result.location else { return nil }
                
                return Location(name: name,
                                latitude: location.coordinate.latitude,
                                longitude: location.coordinate.longitude)
            }
            self.locations = locs
        }
    }
    
    private var isQuerying = false {
        didSet {
            queryingStatusDidChange?(isQuerying)
        }
    }
    private var locations: [Location] = [] {
        didSet {
            locationsDidChanges?(locations)
        }
    }
    
    var numberOfLocations: Int {
        return locations.count
    }
    
    private var hasLocationsResult: Bool {
        return numberOfLocations > 0
    }
    
    func location(at index: Int) -> Location? {
        guard index < numberOfLocations else {
            return nil
        }
        return locations[index]
    }
    
    func locationViewModel(at index: Int) -> LocationRepresentable? {
       
        guard let location = location(at: index) else {
            return nil
        }
        return LocationsViewModel(location: location.location, locationText: location.name)
    }
    
    var queryingStatusDidChange:((Bool) -> Void)?
    var locationsDidChanges:(([Location]) -> Void)?
}






