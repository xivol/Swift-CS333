//
//  TracksStore.swift
//  track-my-steps
//
//  Created by Илья Лошкарёв on 14.04.17.
//  Copyright © 2017 Илья Лошкарёв. All rights reserved.
//

import Foundation
import CoreLocation

protocol TrackManagerDelegate: class {
    func trackManager(_ trackManager: TrackManager, didStopTracking track: Track)
    func trackManager(_ trackManager: TrackManager, didStartTracking track: Track)
    
    func trackManager(_ trackManager: TrackManager, didFinishAuthorizationWithError error: Error)
    func trackManager(_ trackManager: TrackManager, didFinishAuthorizationWithStatus status: CLAuthorizationStatus)
}

class TrackManager: NSObject, CLLocationManagerDelegate {
    // static let shared = TrackManager()
    
    let locationManager = CLLocationManager()
    var tracks = [Track]()
    
    var updateInterval: TimeInterval = 15
    private(set) var isRunning: Bool = false
    
    weak var delegate: TrackManagerDelegate?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    }
    
    func start() {
        if let lastTrack = tracks.last,
            lastTrack.endTime == nil {
            lastTrack.endTime = Date()
        }
        
        let newTrack = Track()
        
        tracks.append(newTrack)
        
        locationManager.startUpdatingLocation()
        locationManager.allowsBackgroundLocationUpdates = true
        isRunning = true
        
        delegate?.trackManager(self, didStartTracking: newTrack)
    }
    
    func stop() {
        locationManager.stopUpdatingLocation()
        isRunning = false
        if let lastTrack = tracks.last {
            lastTrack.endTime = Date()
            delegate?.trackManager(self, didStopTracking: lastTrack)
        }
    }
    
    func pause() {
        locationManager.stopUpdatingLocation()
        isRunning = false
    }
    
    func resume() {
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        isRunning = true
    }
    
    var isAuthorized: Bool {
        let status = CLLocationManager.authorizationStatus()
        return status == .authorizedAlways || status == .authorizedWhenInUse
    }
    
    func authorize(with authorizationStatus: CLAuthorizationStatus){
        switch authorizationStatus {
        case .authorizedAlways:
            locationManager.requestAlwaysAuthorization()
        case .authorizedWhenInUse:
            locationManager.requestWhenInUseAuthorization()
        default:
            break
            delegate?.trackManager(self, didFinishAuthorizationWithError:
                NSError(domain: "Authorization.InvalidStatus", code: 0, userInfo: [:]))
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        delegate?.trackManager(self, didFinishAuthorizationWithStatus: status)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let track = tracks.last else {return}
        for location in locations {
            if location.timestamp > track.startTime
            {
                if let last = track.locations.last {
                    track.distance += location.distance(from: last)
                }
                track.locations.append(location)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFinishDeferredUpdatesWithError error: Error?) {
        guard let error = error else { return }
        print(error.localizedDescription)
    }
}
