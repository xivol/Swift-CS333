//
//  Note+Fetch.swift
//  notes-core-data
//
//  Created by Илья Лошкарёв on 22.03.17.
//  Copyright © 2017 Илья Лошкарёв. All rights reserved.
//

import CoreData

extension Note {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note");
    }
    
    @nonobjc public class func fetchResults(for request: NSFetchRequest<Note>, withDelegate delegate: NSFetchedResultsControllerDelegate? = nil) -> NSFetchedResultsController<Note> {
        if request.sortDescriptors == nil {
            // Sort descriptor is required
            request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        }
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataContainer.context, sectionNameKeyPath: nil, cacheName: "Master")
        fetchedResultsController.delegate = delegate
    
        return fetchedResultsController
    }
}
