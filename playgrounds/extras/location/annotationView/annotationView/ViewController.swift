//
//  ViewController.swift
//  annotationView
//
//  Created by Илья Лошкарёв on 15.04.17.
//  Copyright © 2017 Илья Лошкарёв. All rights reserved.
//

import UIKit
import MapKit
import Contacts

class ViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
            mapView.delegate = self
            mapView.showsUserLocation = true
        } else {
            showError(NSError(domain: "Location Services Unavailiable", code: 0, userInfo: [:]))
        }
        
        initMMCS()
    }
    
    func initMMCS() {
        CLGeocoder().reverseGeocodeLocation(MMCSAnnotation.location){
            placemarks, error in
            guard let places = placemarks else {
                fatalError("Empty geocoder result")
            }
            guard error == nil else {
                self.showError(error!)
                return
            }
            for place in places {
                let marker = MMCSAnnotation(placemark: place)
                self.mapView.addAnnotation(marker)
            }
        }
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation !== mapView.userLocation {
            let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
            pin.pinTintColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            pin.canShowCallout = true
            
            let infoButton = UIButton(type: .detailDisclosure)
            pin.rightCalloutAccessoryView = infoButton
            
            let navButton = UIButton(type: .system)
            navButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            navButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
            
            navButton.setImage(#imageLiteral(resourceName: "Car").withRenderingMode(.alwaysTemplate), for: .normal)
            navButton.backgroundColor = navButton.tintColor
            navButton.tintColor = UIColor.white
            
            pin.leftCalloutAccessoryView = navButton
            
            return pin
        }
        return nil
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let annotation = view.annotation! as? MMCSAnnotation {
            if control === view.leftCalloutAccessoryView {
                annotation.mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
            } else {
                UIApplication.shared.open(annotation.url, options: [:], completionHandler: nil)
            }
        }
    }
    
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 1000, 1000)
        mapView.setRegion(region, animated: true)
        
        // remove outdated route
        for overlay in mapView.overlays {
            mapView.remove(overlay)
        }
        
        // create route request
        let routeRequest = MKDirectionsRequest()
        routeRequest.source = MKMapItem(placemark: MKPlacemark(coordinate: userLocation.coordinate))
        routeRequest.destination = MKMapItem(placemark: MKPlacemark(coordinate: MMCSAnnotation.location.coordinate))
        
        routeRequest.transportType = .automobile
        routeRequest.requestsAlternateRoutes = false
        
        let directions = MKDirections(request: routeRequest)
        
        directions.calculate {
            response, error in
            guard error == nil else {
                self.showError(error!)
                return
            }
            if let route = response?.routes.first {
                mapView.addOverlays([route.polyline], level: .aboveRoads)
                mapView.setVisibleMapRect(route.polyline.boundingMapRect * 1.5, animated: true)
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            renderer.lineWidth = 4.0
            return renderer
        }
        return MKOverlayRenderer()
    }
    
    func showError(_ error: Error) {
        let error = error as NSError
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}

func * ( _ rect: MKMapRect, _ scale: Double) -> MKMapRect {
    let center = MKMapPointMake(rect.origin.x + rect.size.width / 2, rect.origin.y + rect.size.height / 2)
    let size = MKMapSizeMake(rect.size.width * scale, rect.size.height * scale)
    let origin = MKMapPointMake(center.x-size.width/2, center.y-size.height/2)
    return MKMapRectMake(origin.x, origin.y, size.width, size.height)
}


