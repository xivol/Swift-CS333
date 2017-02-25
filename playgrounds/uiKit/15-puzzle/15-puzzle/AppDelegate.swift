//
//  AppDelegate.swift
//  15-puzzle
//
//  Created by Илья Лошкарёв on 19.02.17.
//  Copyright © 2017 Илья Лошкарёв. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? =  UIWindow(frame: UIScreen.main.bounds)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        srand48(Int(Date.timeIntervalSinceReferenceDate)) // seed for UIColor.random
        
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: true)
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
        return true
    }

}

