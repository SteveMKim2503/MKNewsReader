//
//  NewsListViewController+NewsListSectionType.swift
//  MKNewsReader
//
//  Created by MK on 6/22/24.
//

import Foundation

extension NewsListViewController {
    
    enum NewsListSectionType: Equatable {
        case header(_ title: String)
        case newsContent(_ newsContents: [NewsContent])
    }
}
