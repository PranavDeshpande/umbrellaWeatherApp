//
//  DailyWeather.swift
//  umbrella
//
//  Created by Pranav Shashikant Deshpande on 9/17/17.
//  Copyright © 2017 Pranav Shashikant Deshpande. All rights reserved.
//

import Foundation

struct DailyWeather {
    var headerTitle: String?
    var dailyHigh: String?
    var dailyLow: String?
    var lowIndex: Int?
    var highIndex: Int?
    var hourlyWeather: [HourlyWeather] = []
}
