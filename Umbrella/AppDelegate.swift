//
//  AppDelegate.swift
//  umbrella
//
//  Created by Pranav Shashikant Deshpande on 9/17/17.
//  Copyright © 2017 Pranav Shashikant Deshpande. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
       
        UIApplication.shared.statusBarStyle = .lightContent
        
        
        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
        
     
        let mvc = self.window!.rootViewController as! MainViewController
        mvc.retrieveWeatherForecast()
     
    }

}

