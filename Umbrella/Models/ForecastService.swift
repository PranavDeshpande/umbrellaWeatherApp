//
//  ForecastService.swift
//  umbrella
//
//  Created by Pranav Shashikant Deshpande on 9/17/17.
//  Copyright © 2017 Pranav Shashikant Deshpande. All rights reserved.
//

import Foundation

enum ForecastResult {
    case success(Forecast)
    case error(NSError)
}

struct ForecastService {
    
    
   
    func getForecast(_ URL: Foundation.URL, completion: @escaping (ForecastResult) -> Void) -> Void {
        let networkOperation = NetworkOperation(url: URL)
   
        networkOperation.downloadJSONFromURL { (result: NetworkResult) -> Void in
            
            switch result {
                case .success(let f):
                    let forecast = Forecast(weatherDictionary: f)
                    completion(ForecastResult.success(forecast))
                case .error(let e):
                    completion(ForecastResult.error(e))
            }
        }
        
        
        
    }
    
}
