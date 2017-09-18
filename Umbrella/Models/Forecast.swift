//
//  Forecast.swift
//  umbrella
//
//  Created by Pranav Shashikant Deshpande on 9/17/17.
//  Copyright © 2017 Pranav Shashikant Deshpande. All rights reserved.
//

import Foundation

struct Forecast {
    var errors: WeatherError?
    var currentWeather: CurrentWeather?
    var hourly: [HourlyWeather] = []
    
   
    init(weatherDictionary: [String: AnyObject]?) {
        if let responseDictionary = weatherDictionary?["response"] as? [String: AnyObject] {
            errors = WeatherError(errorDictionary: responseDictionary)
        }
        
        if let currentWeatherDictionary = weatherDictionary?["current_observation"] as? [String: AnyObject] {
            currentWeather = CurrentWeather(weatherDictionary: currentWeatherDictionary)
        }
        
        if let hourlyWeatherArray = weatherDictionary?["hourly_forecast"] as? [[String: AnyObject]] {
            for hourlyWeather in hourlyWeatherArray {
                let hour = HourlyWeather(hourlyWeatherDict: hourlyWeather)
                hourly.append(hour)
            }
        }
    }
    
}
