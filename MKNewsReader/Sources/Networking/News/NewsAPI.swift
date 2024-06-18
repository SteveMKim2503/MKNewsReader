//
//  NewsAPI.swift
//  MKNewsReader
//
//  Created by MK on 6/19/24.
//

import Foundation
import Alamofire

/// networking API for news
enum NewsAPI: API {
    /// get korean top headline news
    case koreanTopHeadlineNews
    
    /// path for url component
    var path: String {
        switch self {
        case .koreanTopHeadlineNews:
            return "v2/top-headlines"
        }
    }
    /// HTTP request method
    var method: HTTPMethod {
        switch self {
        case .koreanTopHeadlineNews:
            return .get
        }
    }
    /// request parameters
    var parameters: [String : any Encodable]? {
        switch self {
        case .koreanTopHeadlineNews:
            return [
                "country": "kr",
                "apiKey": ""
            ]
        }
    }
}
