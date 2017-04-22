//
//  Picture+CoreDataProperties.swift
//  apod-viewer
//
//  Created by Илья Лошкарёв on 18.04.17.
//  Copyright © 2017 Илья Лошкарёв. All rights reserved.
//

import Foundation
import CoreData

import UIKit

@objc(Picture)
public class Picture: NSManagedObject {
    
    @NSManaged public var title: String?
    @NSManaged public var subtitle: String?
    @NSManaged public var date: Date?
    @NSManaged public var source: String?
    @NSManaged public var url: URL?
    
    init(title: String, subtitle: String, date: Date, source: String){
        super.init(entity: Picture.entity(), insertInto: CoreDataContainer.context)
        self.title = title
        self.subtitle = subtitle
        self.date = date
        self.source = source
    }
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Picture> {
        return NSFetchRequest<Picture>(entityName: "Picture");
    }
    
    @nonobjc class func controller(for request: NSFetchRequest<Picture>, withDelegate delegate: NSFetchedResultsControllerDelegate? = nil) -> PicturesController {
        if request.sortDescriptors == nil {
            // Sort descriptor is required
            request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        }
        let fetchedResultsController = PicturesController(fetchRequest: request, managedObjectContext: CoreDataContainer.context, sectionNameKeyPath: nil, cacheName: "Master")
        fetchedResultsController.delegate = delegate
        
        return fetchedResultsController
    }
    
}
