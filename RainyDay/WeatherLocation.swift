//
//  WeatherLocation.swift
//  RainyDay
//
//  Created by Marlon Mingo on 8/7/16.
//  Copyright © 2016 aptori.com. All rights reserved.
//

import Foundation
import CoreLocation

class WeatherLocation: NSObject, CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()
    private var currentLocation: CLLocation!
    
    
    func requestCurrentLocation () {
        
        
        print("Getting Location!")
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        //ask permission when active
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        updateLocation()
    }
    
    func updateLocation() {
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            updateCoordinates(with: currentLocation)
        } else {
            locationManager.requestWhenInUseAuthorization()
            updateLocation()
        }
    }
    
    func updateCoordinates(with currentCoords: CLLocation){
        Location.sharedInstance.latitude = currentCoords.coordinate.latitude
        Location.sharedInstance.longitude = currentCoords.coordinate.longitude
    }
}
