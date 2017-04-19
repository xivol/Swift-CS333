//
//  MapViewController.swift
//  track-my-steps
//
//  Created by Илья Лошкарёв on 14.04.17.
//  Copyright © 2017 Илья Лошкарёв. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var track: Track?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.showsBuildings = true
        mapView.mapType = .satellite
        
        if let track = track {
            showTrack(track)
        }
    }
    
    func showTrack(_ track: Track) {
        var points = [MKMapPoint]()
        
        for location in track.locations {
            let pin = MKPointAnnotation.init()
            pin.coordinate = location.coordinate
            pin.title = location.timestamp.description

            mapView.addAnnotation(pin)
            
            points.append(MKMapPointForCoordinate(location.coordinate))
        }
        
        let route = MKPolyline.init(points: UnsafePointer<MKMapPoint>(points), count: points.count)
        mapView.addOverlays([route], level: .aboveRoads)
        
        mapView.showAnnotations(mapView.annotations, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            renderer.lineWidth = 4.0
            return renderer
        }
        fatalError()
    }
}
