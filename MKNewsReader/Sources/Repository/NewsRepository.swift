//
//  NewsRepository.swift
//  MKNewsReader
//
//  Created by MK on 6/20/24.
//

import Foundation
import Combine

protocol NewsRepositoryProtocol: AnyObject {
    var newsContentsPublisher: AnyPublisher<[NewsContent], Never> { get }
    
    func fetchTopHeadlineNews()
    func updateAsRead(newsContentID: UUID)
    func saveImageData(_ imageData: Data, newsContentID: UUID)
}

final class NewsRepository: ObservableObject, NewsRepositoryProtocol {
    
    // MARK: - Property
    
    var newsContentsPublisher: AnyPublisher<[NewsContent], Never> {
        newsContentsSubject.eraseToAnyPublisher()
    }
    
    private let newsContentsSubject = CurrentValueSubject<[NewsContent], Never>([])
    private let newsAPIService: NewsAPIServiceProtocol
    private let newsDBService: NewsDBServiceProtocol
    private var cancellableBag = Set<AnyCancellable>()
    
    // MARK: - Init
    
    init(
        newsAPIService: NewsAPIServiceProtocol = NewsAPIService(),
        newsDBService: NewsDBServiceProtocol = NewsDBService()
    ) {
        self.newsAPIService = newsAPIService
        self.newsDBService = newsDBService
    }
    
    // MARK: - Function
    
    func fetchTopHeadlineNews() {
        newsAPIService.topHeadlineNews()
            .map(mapTopHeadlineEntityToNewsContents)
            .handleEvents(receiveOutput: saveNewsContentsToDatabase)
            .catch { [weak self] error -> AnyPublisher<[NewsContent], Never> in
                dump(error, name: "Networking error")
                
                let dbEntities = self?.fetchNewsContentsFromDatabase() ?? []
                let newsContents = self?.mapNewsContentDBEntitiesToNewsContents(dbEntities) ?? []
                return Just(newsContents).eraseToAnyPublisher()
            }
            .map(sortedNewsContentUsingPublishedAt)
            .assign(to: \.value, on: newsContentsSubject)
            .store(in: &cancellableBag)
    }
    
    func updateAsRead(newsContentID: UUID) {
        let newNewsContents: [NewsContent] = newsContentsSubject.value.compactMap { newsContent in
            guard newsContent.id == newsContentID else { return newsContent }
            
            var newNewsContent = newsContent
            newNewsContent.isRead = true
            return newNewsContent
        }
        newsContentsSubject.send(newNewsContents)
        
        if let dbEntity = newsDBService.fetchNewsContent(using: newsContentID) {
            dbEntity.isRead = true
            newsDBService.updateNewsContent(dbEntity)
        }
    }
    
    func saveImageData(_ imageData: Data, newsContentID: UUID) {
        let newNewsContents: [NewsContent] = newsContentsSubject.value.compactMap { newsContent in
            guard newsContent.id == newsContentID else { return newsContent }
            
            var newNewsContent = newsContent
            newNewsContent.imageData = imageData
            return newNewsContent
        }
        newsContentsSubject.send(newNewsContents)
        
        if let dbEntity = newsDBService.fetchNewsContent(using: newsContentID) {
            dbEntity.imageData = imageData
            newsDBService.updateNewsContent(dbEntity)
        }
    }
}

// MARK: - Private Function

private extension NewsRepository {
    
    func mapTopHeadlineEntityToNewsContents(_ entity: TopHeadlineEntity) -> [NewsContent] {
        return entity.articles.compactMap { article in
            return NewsContent(
                title: article.title,
                publishedAt: article.publishedAt,
                imageURL: article.urlToImage,
                imageData: nil,
                isRead: false
            )
        }
    }
    
    func mapNewsContentDBEntitiesToNewsContents(_ entities: [NewsContentDBEntity]) -> [NewsContent] {
        return entities.compactMap { entity in
            let imageURL: URL? = {
                guard let imageURLString = entity.imageURLString else { return nil }
                return URL(string: imageURLString)
            }()
            return NewsContent(
                title: entity.title,
                publishedAt: entity.publishedAt,
                imageURL: imageURL,
                imageData: entity.imageData,
                isRead: entity.isRead
            )
        }
    }
    
    func fetchNewsContentsFromDatabase() -> [NewsContentDBEntity]? {
        return newsDBService.fetchNewsContents()
    }
    
    func saveNewsContentsToDatabase(_ newsContents: [NewsContent]) {
        newsDBService.deleteAllNewsContents()
        newsDBService.saveNewsContents(newsContents)
    }
    
    func sortedNewsContentUsingPublishedAt(_ newsContents: [NewsContent]) -> [NewsContent] {
        return newsContents.sorted(by: {
            $0.publishedAt ?? Date(timeIntervalSince1970: 0) < $1.publishedAt ?? Date(timeIntervalSince1970: 0)
        })
    }
}
