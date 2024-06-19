//
//  TopHeadlineEntity.swift
//  MKNewsReader
//
//  Created by MK on 6/19/24.
//

import Foundation

struct TopHeadlineEntity: Codable {
    let status: String
    let totalResults: Int
    let articles: [ArticleEntity]
}
