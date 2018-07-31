//
//  AppDelegate.swift
//  StockPortfolioApp
//
//  Created by Sujay Bhowmick on 6/4/18.
//  Copyright © 2018 Sujay Bhowmick. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        preLoadData()
        return true
    }
    
    private func preLoadData() {
        let defaults = UserDefaults.standard
        let isPreloaded = defaults.bool(forKey: "isPreloaded")
      
        if !isPreloaded {
            do {
                try CoreDataStack.shared().dropAllData()
            }catch {
                print(error)
            }
            CoreDataStack.shared().preLoadData()
            defaults.set(true, forKey: "isPreloaded")
        }
    }
}

