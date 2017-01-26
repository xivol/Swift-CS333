//
//  Grade+CoreDataProperties.swift
//  schedule
//
//  Created by Илья Лошкарёв on 20.01.17.
//  Copyright © 2017 Илья Лошкарёв. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Grade {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Grade> {
        return NSFetchRequest<Grade>(entityName: "Grade");
    }

    @NSManaged public var degree: Int16
    @NSManaged public var number: Int16
    @NSManaged public var groups: NSSet?

}

// MARK: Generated accessors for groups
extension Grade {

    @objc(addGroupsObject:)
    @NSManaged public func addToGroups(_ value: Group)

    @objc(removeGroupsObject:)
    @NSManaged public func removeFromGroups(_ value: Group)

    @objc(addGroups:)
    @NSManaged public func addToGroups(_ values: NSSet)

    @objc(removeGroups:)
    @NSManaged public func removeFromGroups(_ values: NSSet)

}
