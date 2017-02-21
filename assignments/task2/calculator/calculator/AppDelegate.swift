//
//  AppDelegate.swift
//  calculator
//
//  Created by Илья Лошкарёв on 18.02.17.
//  Copyright © 2017 Илья Лошкарёв. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let navigation = UINavigationController()
        navigation.addChildViewController(CalculatorController())
        navigation.view.backgroundColor = UIColor.white
        
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
        return true
    }
}

