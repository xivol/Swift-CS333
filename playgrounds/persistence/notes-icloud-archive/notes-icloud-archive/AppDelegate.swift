//
//  AppDelegate.swift
//  notes-archive
//
//  Created by Илья Лошкарёв on 18.03.17.
//  Copyright © 2017 Илья Лошкарёв. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?
    
    weak var storage: NSCoding?
    var filePath: String!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let splitViewController = self.window!.rootViewController as! UISplitViewController
        splitViewController.delegate = self
        
        let navigationController = splitViewController.viewControllers.last! as! UINavigationController
        navigationController.topViewController!.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem

        return true
    }

    func unarchiveStorage(atPath pathToStorage: String?) -> NSCoding? {
        if pathToStorage != nil {
            filePath = pathToStorage
        } else {
            let lib = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first!
            filePath = lib.appendingPathComponent("storage.str").path
            UserDefaults.standard.set(filePath, forKey: "filePath")
        }
        // Unarchiving storage
        if FileManager.default.fileExists(atPath: filePath) {
            return NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? NSCoding
        }
        return nil
    }
    
    func archive(storage: NSCoding?, toPath pathToStorage: String?) {
        if pathToStorage != nil {
            filePath = pathToStorage
        } else {
            let lib = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first!
            filePath = lib.appendingPathComponent("storage.str").path
            UserDefaults.standard.set(filePath, forKey: "filePath")
        }
        
        if let archivingStorage = storage {
            NSKeyedArchiver.archiveRootObject(archivingStorage, toFile: filePath)
        } else {
            print("nothing to archive")
        }
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        archive(storage: storage, toPath: UserDefaults.standard.string(forKey: "filePath") )
    }

    // MARK: - Split view

    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController:UIViewController) -> Bool {
        guard let secondaryAsNavController = secondaryViewController as? UINavigationController
        else { return false }
        guard let topAsDetailController = secondaryAsNavController.topViewController as? DetailViewController
        else { return false }
        if topAsDetailController.detailItem == nil {
            // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
            return true
        }
        return false
    }

}

