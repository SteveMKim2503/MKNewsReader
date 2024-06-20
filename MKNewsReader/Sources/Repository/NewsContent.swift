//
//  NewsContent.swift
//  MKNewsReader
//
//  Created by MK on 6/20/24.
//

import UIKit

struct NewsContent: Identifiable, Equatable {
    let id: UUID = UUID()
    
    let title: String?
    let publishedAt: Date?
    let imageURL: URL?
    var image: UIImage?
    var isRead: Bool
}
