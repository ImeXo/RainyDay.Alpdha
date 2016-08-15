//
//  WeahterData.swift
//  RainyDay
//
//  Created by Marlon Mingo on 8/6/16.
//  Copyright © 2016 aptori.com. All rights reserved.
//

import UIKit


class WeatherData {
    
    private var _jsonDictionary: NSDictionary = [:]
    
    private var _cityName: String!
    private var _date: String!
    private var _weatherType: String!
    private var _currentTemp: Double!
    private var _lowTemp: Double!
    private var _highTemp: Double!
 
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        
        let dayFormat = DateFormatter()
        dayFormat.dateFormat = "EEEE"
        _date = dayFormat.string(from: Date())
        
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        
        return _weatherType
    }
    
    var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        
        return _currentTemp
    }
    var lowTemp: Double {
        if _lowTemp == nil {
            _lowTemp = 0.0
        }
        
        return _lowTemp
    }
    var highTemp: Double {
        if _highTemp == nil {
            _highTemp = 0.0
        }
        
        return _highTemp
    }
    
    
    //:::::::::::::::::::::::::::Download Weather Data - START::::::::::::::::::::::::::::::://
    /*
      take URL path as string and downloads the data to jsonData then converts the NSdata to
      readable string. The string is then converted to a dictionary object to parse the information.
    */
 
    func downloadWeatherData(fromURL: String) {
        
        if let jsonData = NSData(contentsOf: URL(string: fromURL)!) {
            if let stringData = String(data: jsonData as Data, encoding: String.Encoding.utf8) { //convert NSData to String
                
                let sData = stringData.data(using: String.Encoding.utf8)
                do {
                    _jsonDictionary = try JSONSerialization.jsonObject(with: sData!, options: []) as! [String: AnyObject] //Convert String data to Dictionary
                    
                    if let city = _jsonDictionary["name"] as? String {
                        _cityName = city
                        
//                        print(_cityName)
                    }
                    
                    if let weather = _jsonDictionary["weather"] as? [[String: AnyObject]] {
                        if let type = weather[0]["description"] as? String {
                            _weatherType = type
                            
//                            print(_weatherType)
                        }
                    }
                    
                    if let temps = _jsonDictionary["main"] as? [String: AnyObject] {
                        //current temperature
                        if let cTemp = temps["temp"] as? Double {
                            _currentTemp = round((cTemp * (9/5)) - 459.67)
                        }
                        //current lows for the day
                        if let lTemp = temps["temp_min"] as? Double {
                            _lowTemp = round((lTemp * (9/5)) - 459.67)
                        }
                        //current highs for the day
                        if let hTemp = temps["temp_max"] as? Double {
                            _highTemp = round((hTemp * (9/5)) - 459.67)
                        }
                    }
                    
//                    print("\n\n\n\(_jsonDictionary)\n\n\n\(_jsonDictionary["name"]!)\n\n\n")
                } catch let err as NSError {
                    print(err)
                }
            }
        }
    }
    
    //:::::::::::::::::::::::::::Download Weather Data - END::::::::::::::::::::::::::::::://
    
}
