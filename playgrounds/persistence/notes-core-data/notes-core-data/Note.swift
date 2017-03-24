//
//  Note+CoreDataClass.swift
//  notes-core-data
//
//  Created by Илья Лошкарёв on 22.03.17.
//  Copyright © 2017 Илья Лошкарёв. All rights reserved.
//

import UIKit
import CoreData

@objc(Note)
public class Note: NSManagedObject {
    
    @NSManaged public var date: NSDate?
    @NSManaged public var content: String?
    @NSManaged public var color: UIColor?
    
    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    public convenience init(content: String) {
        self.init(entity: Note.entity(), insertInto: CoreDataContainer.context)
        self.content = content
        self.date = Date() as NSDate
        self.color = UIColor.random
    }
    
    // MARK: String Convertable
    
    static let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "hh:mm:ss dd.MM.yyyy"
        return df
    }()
    
    override public var description: String {
        return "(\(Note.dateFormatter.string(from: date as! Date))) " + content!
    }
}
