//
//  NewsContent.swift
//  MKNewsReader
//
//  Created by MK on 6/20/24.
//

import Foundation

struct NewsContent: Identifiable, Equatable {
    let id: UUID = UUID()
    
    let title: String?
    let publishedAt: Date?
    let imageURL: URL?
    let contentURL: URL?
    var imageData: Data?
    var isRead: Bool
}
