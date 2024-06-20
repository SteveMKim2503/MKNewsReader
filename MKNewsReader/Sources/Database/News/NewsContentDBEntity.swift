//
//  NewsContentDBEntity.swift
//  MKNewsReader
//
//  Created by MK on 6/20/24.
//

import Foundation
import CoreData

@objc(NewsContentDBEntity)
public class NewsContentDBEntity: NSManagedObject {
    @NSManaged public var id: UUID
    @NSManaged public var title: String?
    @NSManaged public var publishedAt: Date?
    @NSManaged public var imageURLString: String?
    @NSManaged public var imageData: Data?
    @NSManaged public var isRead: Bool
}

extension NewsContentDBEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewsContentDBEntity> {
        let entityName = String(describing: self)
        return NSFetchRequest<NewsContentDBEntity>(entityName: entityName)
    }
}
