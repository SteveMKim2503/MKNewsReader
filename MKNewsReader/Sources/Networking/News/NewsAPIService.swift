//
//  NewsAPIService.swift
//  MKNewsReader
//
//  Created by MK on 6/18/24.
//

import Foundation
import Combine

protocol NewsAPIServiceProtocol {
    func topHeadlineNews() -> APIPublisher<TopHeadlineEntity>
}

class NewsAPIService: BaseAPIService, NewsAPIServiceProtocol {
    func topHeadlineNews() -> APIPublisher<TopHeadlineEntity> {
        return request(api: NewsAPI.koreanTopHeadlineNews, type: TopHeadlineEntity.self)
    }
}
