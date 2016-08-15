//
//  ForcastCell.swift
//  RainyDay
//
//  Created by Marlon Mingo on 8/13/16.
//  Copyright © 2016 aptori.com. All rights reserved.
//

import UIKit

class ForecastCell: UITableViewCell {

    @IBOutlet weak var forecastDayLabel: UILabel!
    @IBOutlet weak var forecastDayHighsLabel: UILabel!
    @IBOutlet weak var forecastDayLowsLabel: UILabel!
    //    @IBOutlet weak var forecastConditionImage: UIImageView!

    private var _date: String!
    private var _lowTemp: Double!
    private var _highTemp: Double!
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        
        return _date
    }
    func configureCells(with forecastData: [String:AnyObject]) {
        
        if let temps = forecastData["temp"] as? [String:AnyObject] {
            //forecast lows
            if let lTemp = temps["min"] as? Double {
                _lowTemp = round((lTemp * (9/5)) - 459.67)
                forecastDayLowsLabel.text = "\(Int(_lowTemp))"
            }
            //forecast highs
            if let hTemp = temps["max"] as? Double {
                _highTemp = round((hTemp * (9/5)) - 459.67)
                forecastDayHighsLabel.text = "\(Int(_highTemp))"
            }
        }
        
        if let date = forecastData["dt"] as? Double {
            let unixDate = Date(timeIntervalSince1970: date)
            _date = unixDate.dayOfWeek()
            forecastDayLabel.text = _date
        }
    }
}

extension Date {
    func dayOfWeek() -> String {
        let dayFormat = DateFormatter()
        dayFormat.dateFormat = "EEEE"
        return dayFormat.string(from: self)
    }
}
