//
//  StringFile.swift
//  umbrella
//
//Created by Pranav Shashikant Deshpande on 9/17/17.
//  Copyright © 2017 Pranav Shashikant Deshpande. All rights reserved.
//

import Foundation

extension String {
    
    
    
    func nrd_weatherIconURL(highlighted: Bool = false) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "nerdery-umbrella.s3.amazonaws.com"
        
        if highlighted {
            urlComponents.path = "/\(self)-selected.png"
        } else {
            urlComponents.path = "/\(self).png"
        }
        
        return urlComponents.url
    }
    
}
