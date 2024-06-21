//
//  NewsListViewController+ViewHolder.swift
//  MKNewsReader
//
//  Created by MK on 6/20/24.
//

import UIKit
import SnapKit

extension NewsListViewController {
    
    final class ViewHolder {
        
        // MARK: - View
        
        private(set) lazy var newsListCollectionView: UICollectionView = {
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
            collectionView.register(HeaderCell.self)
            collectionView.register(NewsContentCell.self)
            return collectionView
        }()
        
        // MARK: - Configure
        
        func place(in view: UIView) {
            view.addSubview(newsListCollectionView)
        }
        
        func configureConstraints(for view: UIView) {
            newsListCollectionView.snp.makeConstraints { make in
                make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
                make.bottom.equalToSuperview()
            }
        }
    }
}
