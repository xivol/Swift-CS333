//
//  AppDelegate.swift
//  local-notification
//
//  Created by Илья Лошкарёв on 21.04.17.
//  Copyright © 2017 Илья Лошкарёв. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        if let controller = window?.rootViewController as? ViewController {
            controller.center.removeAllPendingNotificationRequests()
        }
    }


}

