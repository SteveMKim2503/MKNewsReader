//
//  NewsListViewController+HeaderCell.swift
//  MKNewsReader
//
//  Created by MK on 6/20/24.
//

import UIKit

extension NewsListViewController {
    
    final class HeaderCell: BaseCollectionViewCell {
        
        // MARK: - Property
        
        var title: String? { didSet { update() }}
        
        // MARK: - View
        
        private lazy var headerView: HeaderView = {
            return HeaderView()
        }()
        
        // MARK: - Configure
        
        override func configureViews() {
            super.configureViews()
            
            addSubview(headerView)
        }
        
        override func configureConstraints() {
            super.configureConstraints()
            
            headerView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
        
        override func update() {
            super.update()
            
            headerView.title = title
        }
    }
}

extension NewsListViewController.HeaderCell {
    
    static func  makeCell(
        to view: UICollectionView,
        indexPath: IndexPath,
        title: String
    ) -> NewsListViewController.HeaderCell {
        let cell = view.dequeueReusableCell(
            withClass: NewsListViewController.HeaderCell.self,
            for: indexPath
        )
        cell.title = title
        return cell
    }
}
