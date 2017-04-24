//
//  Track.swift
//  track-my-steps
//
//  Created by Илья Лошкарёв on 13.04.17.
//  Copyright © 2017 Илья Лошкарёв. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

class Track: NSObject, CLLocationManagerDelegate {
    var locations = [CLLocation]()
    var distance: CLLocationDistance = 0
    
    let startTime = Date()
    var endTime: Date? = nil
    
    static let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yyyy HH:mm"
        return df
    }()
    
    static let distanceFormatter: MKDistanceFormatter = {
        let df = MKDistanceFormatter()
        df.units = .metric
        return df
    }()
    
    var isRunning: Bool {
        return endTime == nil
    }
    
    override var description: String {
        return Track.dateFormatter.string(from: startTime) + " - " + Track.distanceFormatter.string(fromDistance: distance)
    }
}
