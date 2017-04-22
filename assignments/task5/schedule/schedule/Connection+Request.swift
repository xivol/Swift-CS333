//
//  Connection+Request.swift
//  schedule
//
//  Created by Илья Лошкарёв on 31.03.17.
//  Copyright © 2017 mmcs. All rights reserved.
//

import Foundation
import UIKit

extension Connection {
    
    static var defaultRetryInterval: TimeInterval { return 5 }
    
    static func request(_ block: @escaping () -> ()) {
        retry(every: defaultRetryInterval, withRequest: block)
    }
    
    static func retry(every retryInterval: TimeInterval, withRequest request: @escaping () -> ()) {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let timer = Timer.scheduledTimer(withTimeInterval: retryInterval, repeats: true) {
            timer in
            if Connection.isAvaliable {
                request()
                timer.invalidate()
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            } else {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: nil, message: "Network connection is required", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    
                    if let vc = UIApplication.shared.delegate?.window??.rootViewController {
                        vc.present(alert, animated: true)
                    }
                }
            }
        }
        
        timer.fire()
    }
}
