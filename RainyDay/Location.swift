//
//  Location.swift
//  RainyDay
//
//  Created by Marlon Mingo on 8/14/16.
//  Copyright © 2016 aptori.com. All rights reserved.
//

import CoreLocation

class Location {
    static var sharedInstance = Location()
    private init() {}
    
    var longitude: Double!
    var latitude: Double!
}
