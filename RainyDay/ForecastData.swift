//
//  ForecastData.swift
//  RainyDay
//
//  Created by Marlon Mingo on 8/11/16.
//  Copyright © 2016 aptori.com. All rights reserved.
//

import UIKit


class ForecastData: UITableViewCell {
    
    private var _jsonDictionary: NSDictionary = [:]
    private var _forecasts = [AnyObject]()
    
    var forecasts: [AnyObject] {
        get { return _forecasts }
    }
    
    
    //:::::::::::::::::::::::::::Download Weather Data - START::::::::::::::::::::::::::::::://
    /*
     take URL path as string and downloads the data to jsonData then converts the NSdata to
     readable string. The string is then converted to a dictionary snd stored in an array.
     */

    func downloadForecastData(fromURL: String) {
        if let jsonData = NSData(contentsOf: URL(string: fromURL)!) {
            if let stringData = String(data: jsonData as Data, encoding: String.Encoding.utf8) { //convert NSData to String
                
                let sData = stringData.data(using: String.Encoding.utf8)
                do {
                    _jsonDictionary = try JSONSerialization.jsonObject(with: sData!, options: []) as! [String: AnyObject] //Convert String data to Dictionary

                    if let jsonList = _jsonDictionary["list"] as? [[String:AnyObject]] {
                        for object in jsonList {
                            
                            self._forecasts.append(object)
                        }
                        self._forecasts.remove(at: 0)
                    }
                    
                } catch let err as NSError {
                    print (err)
                }
            }
        }
    }
    
    //:::::::::::::::::::::::::::Download Forecast Data - END::::::::::::::::::::::::::::::://
}
