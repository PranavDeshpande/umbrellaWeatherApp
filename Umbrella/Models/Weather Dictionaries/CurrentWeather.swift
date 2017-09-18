//
//  CurrentWeather.swift
//  umbrella
//
//  Created by Pranav Shashikant Deshpande on 9/17/17.
//  Copyright © 2017 Pranav Shashikant Deshpande. All rights reserved.
//

import Foundation

struct CurrentWeather {
    
    let temp_c: Double?
    let temp_f: Double?
    let cityState: String?
    let currentConditions: String?
    
    
    
    init(weatherDictionary: [String: AnyObject]) {
        temp_f = weatherDictionary["temp_f"] as? Double
        temp_c = weatherDictionary["temp_c"] as? Double
        cityState = weatherDictionary["display_location"]?["full"] as? String
        currentConditions = weatherDictionary["weather"] as? String
    }
}
