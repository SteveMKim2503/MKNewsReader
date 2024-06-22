//
//  ArticleEntity.swift
//  MKNewsReader
//
//  Created by MK on 6/19/24.
//

import Foundation

struct ArticleEntity: Codable {
    let source: ArticleSourceEntity?
    let author: String?
    let title: String?
    let description: String?
    let url: URL?
    let urlToImage: URL?
    @ISO8601DateWrapper
    var publishedAt: Date?
    let content: String?
}
