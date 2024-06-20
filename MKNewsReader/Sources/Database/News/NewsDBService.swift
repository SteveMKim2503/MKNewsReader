//
//  NewsDBService.swift
//  MKNewsReader
//
//  Created by MK on 6/19/24.
//

import Foundation

protocol NewsDBServiceProtocol {
    func saveNewsContents(_ newsContents: [NewsContent])
    func fetchNewsContent(using newsContentID: UUID) -> NewsContentDBEntity?
    func fetchNewsContents() -> [NewsContentDBEntity]?
    func updateNewsContent(_ entity: NewsContentDBEntity)
    func deleteAllNewsContents()
}

final class NewsDBService: NewsDBServiceProtocol {
    
    private let coreDataHelper = CoreDataHelper.shared
    
    func saveNewsContents(_ newsContents: [NewsContent]) {
        newsContents.forEach { newsContent in
            let entity = self.coreDataHelper.createEntity(ofType: NewsContentDBEntity.self)
            entity.id = newsContent.id
            entity.title = newsContent.title
            entity.publishedAt = newsContent.publishedAt
            entity.imageURLString = newsContent.imageURL?.absoluteString
            entity.isRead = newsContent.isRead
            entity.imageData = newsContent.imageData
        }
        
        coreDataHelper.saveContext()
    }
    
    func fetchNewsContent(using newsContentID: UUID) -> NewsContentDBEntity? {
        return coreDataHelper.fetchEntities(
            ofType: NewsContentDBEntity.self,
            withPredicate: NSPredicate(format: "id == %@", newsContentID as CVarArg)
        ).first
    }
    
    func fetchNewsContents() -> [NewsContentDBEntity]? {
        return coreDataHelper.fetchEntities(ofType: NewsContentDBEntity.self)
    }
    
    func updateNewsContent(_ entity: NewsContentDBEntity) {
        coreDataHelper.updateEntity(entity)
    }
    
    func deleteAllNewsContents() {
        coreDataHelper.deleteAll(ofType: NewsContentDBEntity.self)
    }
}
