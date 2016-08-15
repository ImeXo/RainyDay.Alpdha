//
//  Constants.swift
//  RainyDay
//
//  Created by Marlon Mingo on 8/6/16.
//  Copyright © 2016 aptori.com. All rights reserved.
//

import Foundation

let _APIKEY = "534369f197436c84c44aad931a198cfb"
var _days: Int = 7

let _weatherURL = "http://api.openweathermap.org/data/2.5/weather?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&appid=\(_APIKEY)"
let _forecastURL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&mode=json&cnt=\(_days)&appid=\(_APIKEY)"
