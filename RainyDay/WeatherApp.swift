//
//  ViewController.swift
//  RainyDay
//
//  Created by Marlon Mingo on 8/1/16.
//  Copyright © 2016 aptori.com. All rights reserved.
//

import UIKit

class WeatherApp: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //-----------------------1
    @IBOutlet weak var weatherLocationLabel: UILabel!
    @IBOutlet weak var weatherTempLabel: UILabel!
    @IBOutlet weak var weatherConditionLabel: UILabel!
    
    @IBOutlet weak var currentDayLabel: UILabel!
    @IBOutlet weak var currentDayHighsLabel: UILabel!
    @IBOutlet weak var currentDayLowsLabel: UILabel!
    
    //-----------------------2
    @IBOutlet weak var tableView: UITableView!
    
    var weatherDetails = WeatherData()
    var forecastDetails = ForecastData()
    
    var location = WeatherLocation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = UIColor.clear
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //pull current location
        location.requestCurrentLocation()
        
        //display weather details on the screen
        updateWeatherUI()
        tableView.reloadData()
    }
    
    //::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::://
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastDetails.forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "forecastCell", for: indexPath) as? ForecastCell {
            
            let forecast = forecastDetails.forecasts[indexPath.row]
            cell.configureCells(with: forecast as! [String : AnyObject])
            return cell
        } else {
            return ForecastData()
        }
    }
    
    
    /*
      updates UI with weather information
    */
    func updateWeatherUI() {
        
        //pull weather data
        weatherDetails.downloadWeatherData(fromURL: _weatherURL)
        forecastDetails.downloadForecastData(fromURL: _forecastURL)
        
        //current weather
        self.weatherLocationLabel.text = weatherDetails.cityName.capitalized
        weatherTempLabel.text = "\(Int(weatherDetails.currentTemp))°"
        weatherConditionLabel.text = weatherDetails.weatherType.lowercased()
        
        currentDayLabel.text = weatherDetails.date.capitalized
        currentDayLowsLabel.text = "\(Int(weatherDetails.lowTemp))"
        currentDayHighsLabel.text = "\(Int(weatherDetails.highTemp))"
    }
}
