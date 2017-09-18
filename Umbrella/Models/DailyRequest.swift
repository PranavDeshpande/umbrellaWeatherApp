//
//  DailyRequest.swift
//  umbrella
//
//  Created by Pranav Shashikant Deshpande on 9/17/17.
//  Copyright © 2017 Pranav Shashikant Deshpande. All rights reserved.
//

import Foundation

fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


struct DailyRequest {
    
    fileprivate let hourly: [HourlyWeather]
    let headerOptions = ["Today", "Tomorrow", "Day After Tomorrow"]
    
    
    var Daily: [DailyWeather]? {
        get {
            
            var daily: [DailyWeather] = []
            
            
            
            var dayObj = DailyWeather(
                headerTitle: headerOptions.first,
                dailyHigh: hourly.first?.temp_english,
                dailyLow: hourly.first?.temp_english,
                lowIndex: 0,
                highIndex: 0,
                hourlyWeather: [])
            
            
            for item in hourly {
                
            
                
                if item.timeStamp != "12:00 AM" {
                    if(item.temp_english > dayObj.dailyHigh) {
                        dayObj.dailyHigh = item.temp_english
                        dayObj.highIndex = dayObj.hourlyWeather.count
                    }
                    
                    if(item.temp_english < dayObj.dailyLow) {
                        dayObj.dailyLow = item.temp_english
                        dayObj.lowIndex = dayObj.hourlyWeather.count
                    }
                } else {
                    
                 
                    
                    daily.append(dayObj)
                    
                    
                  
                    
                    dayObj = DailyWeather(
                        headerTitle: headerOptions[daily.count],
                        dailyHigh: item.temp_english,
                        dailyLow: item.temp_english,
                        lowIndex: 0,
                        highIndex: 0,
                        hourlyWeather: [])
                }
                
               
                dayObj.hourlyWeather.append(item)
            }
            
            
            daily.append(dayObj)
            
            
            if(daily.first?.hourlyWeather.count == 0) {
                daily.remove(at: 0)
            }
            
            return daily
            
            
        }
    }

    init(_ hourlyWeather: [HourlyWeather]) {
        self.hourly = hourlyWeather
    }

    
}
    
