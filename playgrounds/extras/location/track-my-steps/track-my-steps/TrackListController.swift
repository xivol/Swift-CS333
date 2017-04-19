//
//  TrackListController.swift
//  track-my-steps
//
//  Created by Илья Лошкарёв on 14.04.17.
//  Copyright © 2017 Илья Лошкарёв. All rights reserved.
//

import UIKit
import CoreLocation

class TrackListController: UITableViewController, TrackManagerDelegate {
    
    unowned var trackManager = (UIApplication.shared.delegate as! AppDelegate).trackManager

    override func viewDidLoad() {
        super.viewDidLoad()
        trackManager.delegate = self
    }

    var isAuthorizationRequired = false
    
    @IBAction func startNewTrack(_ sender: Any) {
        if CLLocationManager.locationServicesEnabled() && trackManager.isAuthorized {
            trackManager.start()
        } else {
            isAuthorizationRequired = true
            trackManager.authorize(with: .authorizedAlways)
        }
    }
    
    // MARK: - Table View data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trackManager.tracks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let track = trackManager.tracks[trackManager.tracks.count - 1 - indexPath.row]
        cell.textLabel?.text = track.description

        return cell
    }
    
    // MARK: - Track Manager
    
    func trackManager(_ trackManager: TrackManager, didStopTracking track: Track) {
        tableView.reloadData()
    }
    
    func trackManager(_ trackManager: TrackManager, didStartTracking track: Track) {}
    
    func trackManager(_ trackManager: TrackManager, didFinishAuthorizationWithStatus status: CLAuthorizationStatus) {
        if status == .authorizedAlways && isAuthorizationRequired {
            isAuthorizationRequired = false
            trackManager.start()
        } else {
            self.trackManager( trackManager, didFinishAuthorizationWithError:
                NSError(domain: "Athorization.WrongStatus", code: 0, userInfo: [:]))
        }
    }
    
    func trackManager(_ trackManager: TrackManager, didFinishAuthorizationWithError error: Error) {}

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let mapController = segue.destination as? MapViewController,
            let selectedRow = tableView.indexPathForSelectedRow?.row {
            mapController.track = trackManager.tracks[trackManager.tracks.count - 1 - selectedRow]
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "showTracking" {
            return trackManager.isAuthorized
        }
        return true
    }
}
