//
//  MMCSAnnotation.swift
//  annotationView
//
//  Created by Илья Лошкарёв on 18.04.17.
//  Copyright © 2017 Илья Лошкарёв. All rights reserved.
//

import Foundation
import MapKit

class MMCSAnnotation: NSObject, MKAnnotation {
    static let location =  CLLocation(latitude: 47.21528640, longitude: 39.62801960)
    
    let url = URL(string: "https://sfedu.ru/www/stat_pages22.show?p=ELS/inf/D&x=ELS/2000000000000")!
    
    let placemark: CLPlacemark!
    
    init(placemark: CLPlacemark){
        self.placemark = placemark
        super.init()
    }
    
    // MARK: - MKAnnotation
    
    var coordinate: CLLocationCoordinate2D {
        return MMCSAnnotation.location.coordinate
    }
    
    var title: String? {
        return NSLocalizedString("Institute of Mathematics, Mechanics and Computer Science", comment: "")
    }
    
    var subtitle: String? {
        if let address = placemark.addressDictionary?["FormattedAddressLines"] as? [String] {
            return address.joined(separator: ", ")
        }
        return nil
    }
    
    var mapItem: MKMapItem {
        let mapItem = MKMapItem(placemark: MKPlacemark(placemark: placemark))
        mapItem.name = title
        
        return mapItem
    }
}
