//
//  Group+CoreDataProperties.swift
//  schedule
//
//  Created by Илья Лошкарёв on 20.01.17.
//  Copyright © 2017 Илья Лошкарёв. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Group {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Group> {
        return NSFetchRequest<Group>(entityName: "Group");
    }

    @NSManaged public var name: String?
    @NSManaged public var number: Int16
    @NSManaged public var grade: Grade?

}
