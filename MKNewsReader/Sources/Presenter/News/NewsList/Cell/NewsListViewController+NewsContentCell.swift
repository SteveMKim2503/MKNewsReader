//
//  NewsListViewController+NewsContentCell.swift
//  MKNewsReader
//
//  Created by MK on 6/20/24.
//

import UIKit

extension NewsListViewController {
    
    final class NewsContentCell: BaseCollectionViewCell {
        
        // MARK: - Property
        
        var content: NewsContentView.Content? { didSet { update() }}
        
        // MARK: - View
        
        private lazy var newsContentView: NewsContentView = {
            return NewsContentView()
        }()
        
        // MARK: - LifeCycle
        
        override func prepareForReuse() {
            super.prepareForReuse()
            
            content = nil
        }
        
        // MARK: - Configure
        
        override func configureViews() {
            super.configureViews()
            
            contentView.addSubview(newsContentView)
        }
        
        override func configureConstraints() {
            super.configureConstraints()
            
            newsContentView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
        
        override func update() {
            super.update()
            
            newsContentView.content = content
        }
    }
}

extension NewsListViewController.NewsContentCell {
    
    static func  makeCell(
        to view: UICollectionView,
        indexPath: IndexPath,
        content: NewsListViewController.NewsContentView.Content
    ) -> NewsListViewController.NewsContentCell {
        let cell = view.dequeueReusableCell(
            withClass: NewsListViewController.NewsContentCell.self,
            for: indexPath
        )
        cell.content = content
        return cell
    }
}
