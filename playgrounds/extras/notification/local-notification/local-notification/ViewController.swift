//
//  ViewController.swift
//  local-notification
//
//  Created by Илья Лошкарёв on 21.04.17.
//  Copyright © 2017 Илья Лошкарёв. All rights reserved.
//

import UIKit
import UserNotifications

extension LocalNotification {
    
    enum Identifier: String {
        case single, repeated, withActions
    }
    
    enum Action: String {
        case open, dismiss
    }
    
    enum Category: String {
        case general
    }
}

class ViewController: UIViewController, LocalNotificationCenterDelegate {
    
    let center = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        center.getNotificationSettings(completionHandler: check(allowedNotificationSettings:))
        center.delegate = self
    }
    
    func check(allowedNotificationSettings settings: UNNotificationSettings) {
        switch settings.authorizationStatus {
        case .notDetermined:
            center.requestAuthorization(options: [.alert, .sound, .badge], completionHandler: authorisationResponse(granted:error:))
        case .denied:
            let alert = UIAlertController(title: "Error", message: "Please Enable Local Notifications", preferredStyle: .alert)
            present(alert, animated: true, completion: nil)
        case .authorized:
            break
        }
    }
    
    func authorisationResponse(granted: Bool, error: Error?) {
        guard !granted else { return }
        
        let alert: UIAlertController
        
        if let error = error {
            alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        } else {
            alert = UIAlertController(title: "Error", message: "Please Enable Local Notifications", preferredStyle: .alert)
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func singleNotification(_ sender: UIButton) {
        let notification = LocalNotification(withIdentifier: LocalNotification.Identifier.single,
                                             deliverTo: center)
        
        notification.content.title = "It's a notification!"
        notification.content.body = "Hello, world!"
        notification.content.sound = UNNotificationSound.default()

        let imageUrl = URL(fileReferenceLiteralResourceName: "cat.gif")
        
        if let attachment = try? UNNotificationAttachment(identifier: "attachmentImage", url: imageUrl, options: nil) {
            notification.content.attachments = [attachment]
        }
        
        notification.schedule(in: 10, repeats: false)
    }
    
    @IBAction func repeatedNotification(_ sender: UIButton) {
        let notification = LocalNotification(withIdentifier: LocalNotification.Identifier.repeated,
                                             deliverTo: center)
        
        notification.content.title = "Repeated notification"
        notification.content.body = "It comes back every minute"
        notification.content.sound = UNNotificationSound.default()
        
        var datePattern = DateComponents()
        datePattern.second = 0
        
        notification.schedule(forDateMatching: datePattern, repeats: true)
    }
    
    @IBAction func actionNotification(_ sender: UIButton) {
        let notification = LocalNotification(withIdentifier: LocalNotification.Identifier.withActions,
                                             deliverTo: center)
        
        notification.content.title = "Action notification"
        notification.content.body = "Notification can have assosiated actions"
        notification.content.sound = UNNotificationSound.default()

        let open = UNNotificationAction(identifier: LocalNotification.Action.open, title: "Open", options: [.foreground])
        let dismiss = UNNotificationAction(identifier: LocalNotification.Action.dismiss, title: "Dismiss", options: [.destructive])
        
        let actionCategory = UNNotificationCategory(identifier: LocalNotification.Category.general, actions: [open, dismiss], intentIdentifiers: [], options: [])
        
        notification.content.categoryIdentifier = actionCategory.identifier

        center.setNotificationCategories([actionCategory])
        
        notification.schedule(in: 5, repeats: false)
    }
    
    @IBAction func stopNotifications(_ sender: UIButton) {
        print("Removed all notification requests")
        center.removePendingNotificationRequests(withIdentifiers: [
            LocalNotification.Identifier.single.rawValue,
            LocalNotification.Identifier.repeated.rawValue,
            LocalNotification.Identifier.withActions.rawValue])
    }
    
    // MARK: LocalNotificationCenterDelegate
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, failedToSheduleNotificationForIdentifier identifier: String, withError error: Error) {
        fatalError(error.localizedDescription)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        print("Tapped in notification")
        if let identifier = LocalNotification.Identifier(rawValue: response.notification.request.identifier) {
            switch identifier {
            case .single:
                print("Single notification recieved")
            case .repeated:
                print("Repeated notification recieved")
            case .withActions:
                print("Action notification recieved")
            }
        }
        
        if let action = LocalNotification.Action(rawValue: response.actionIdentifier) {
            switch action {
            case .open:
                let alert = UIAlertController(title: "Notification", message: "Action has opened the app!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            case .dismiss:
                print("Action Dismiss")
            }
        }
        
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // this happens only in foreground
        print("Wild notification appeared!")
        print("It is \(notification.request.identifier)")
        completionHandler( [.alert, .sound, .badge] )
    }
    
}

