//
//  NewsListViewController+NewsListCollectionViewAdapter.swift
//  MKNewsReader
//
//  Created by MK on 6/20/24.
//

import UIKit
import Combine

extension NewsListViewController {
    
    final class NewsListCollectionViewAdapter: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
        
        var sections: [NewsListSectionType] = []
        var newsContentSelected = PassthroughSubject<UUID, Never>()
        
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return sections.count
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            guard let sectionType = sections[safe: section] else { return 0 }
            
            switch sectionType {
            case .header:
                return 1
            case .newsContent(let newsContents):
                return newsContents.count
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let sectionType = sections[safe: indexPath.section] else {
                fatalError("Failed to get section")
            }
            
            switch sectionType {
            case .header(let title):
                return HeaderCell.makeCell(
                    to: collectionView,
                    indexPath: indexPath,
                    title: title
                )
                
            case .newsContent(let newsContents):
                guard let newsContent = newsContents[safe: indexPath.row] else {
                    fatalError("Failed to get news content")
                }
                let content = NewsContentView.Content(
                    imageURL: newsContent.imageURL,
                    title: newsContent.title,
                    publishedAtString: newsContent.publishedAt?.koreanTimeString,
                    titleColor: newsContent.isRead ? .red : .darkGray
                )
                return NewsContentCell.makeCell(
                    to: collectionView,
                    indexPath: indexPath,
                    content: content
                )
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            guard let sectionType = sections[safe: indexPath.section] else {
                fatalError("Failed to get section")
            }
            
            switch sectionType {
            case .header:
                return
            case .newsContent(let newsContents):
                guard let newsContent = newsContents[safe: indexPath.row] else {
                    fatalError("Failed to get news content")
                }
                newsContentSelected.send(newsContent.id)
            }
        }
    }
}
