//
//  WeatherError.swift
//  umbrella
//
//  Created by Pranav Shashikant Deshpande on 9/17/17.
//  Copyright © 2017 Pranav Shashikant Deshpande. All rights reserved.
//

import Foundation

struct WeatherError {
    
    let errorType: String?
    let errorDescription: String?
    
 
    init(errorDictionary: [String: AnyObject]) {
        errorType = errorDictionary["error"]?["type"] as? String
        errorDescription = errorDictionary["error"]?["description"] as? String
    }
}
