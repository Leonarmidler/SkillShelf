//
//  ProjectEntity+CoreDataProperties.swift
//  ECS Sofa Project
//
//  Created by Leonardo Daniele on 27/01/23.
//
//

import Foundation
import CoreData


extension ProjectEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProjectEntity> {
        return NSFetchRequest<ProjectEntity>(entityName: "ProjectEntity")
    }

    @NSManaged public var idCD: UUID?
    @NSManaged public var image: Data?
    @NSManaged public var summary: String?
    @NSManaged public var title: String?
    @NSManaged public var tags: NSSet?

}

// MARK: Generated accessors for tags
extension ProjectEntity {

    @objc(addTagsObject:)
    @NSManaged public func addToTags(_ value: TagEntity)

    @objc(removeTagsObject:)
    @NSManaged public func removeFromTags(_ value: TagEntity)

    @objc(addTags:)
    @NSManaged public func addToTags(_ values: NSSet)

    @objc(removeTags:)
    @NSManaged public func removeFromTags(_ values: NSSet)

}

extension ProjectEntity : Identifiable {

}
