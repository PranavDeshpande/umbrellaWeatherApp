//
//  UIColor.swift
//  umbrella

//  Created by Pranav Shashikant Deshpande on 9/17/17.
//  Copyright © 2017 Pranav Shashikant Deshpande. All rights reserved.
//

import UIKit

extension UIColor {
    
   

    public convenience init (_ rgbHex: UInt,  alpha: CGFloat = 1.0) {
        let rawRed = Double((rgbHex >> 16) & 0xFF) / 255.0
        let rawGreen = Double((rgbHex >> 8) & 0xFF) / 255.0
        let rawBlue = Double(rgbHex & 0xFF) / 255.0
        self.init(red: CGFloat(rawRed), green: CGFloat(rawGreen), blue: CGFloat(rawBlue), alpha: alpha)
    }
    
}
