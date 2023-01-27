//
//  TagEntity+CoreDataProperties.swift
//  ECS Sofa Project
//
//  Created by Leonardo Daniele on 27/01/23.
//
//

import Foundation
import CoreData


extension TagEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TagEntity> {
        return NSFetchRequest<TagEntity>(entityName: "TagEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var project: NSSet?

}

// MARK: Generated accessors for project
extension TagEntity {

    @objc(addProjectObject:)
    @NSManaged public func addToProject(_ value: ProjectEntity)

    @objc(removeProjectObject:)
    @NSManaged public func removeFromProject(_ value: ProjectEntity)

    @objc(addProject:)
    @NSManaged public func addToProject(_ values: NSSet)

    @objc(removeProject:)
    @NSManaged public func removeFromProject(_ values: NSSet)

}

extension TagEntity : Identifiable {

}
