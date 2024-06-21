//
//  NewsListViewController+HeaderView.swift
//  MKNewsReader
//
//  Created by MK on 6/20/24.
//

import UIKit

extension NewsListViewController {
    
    final class HeaderView: BaseView {
        
        // MARK: - Property
        
        var title: String? { didSet { update() }}
        
        // MARK: - View
        
        private lazy var titleLabel: UILabel = {
            let label = UILabel()
            label.font = .boldSystemFont(ofSize: 20)
            label.textColor = .black
            label.numberOfLines = 1
            return label
        }()
        
        // MARK: - Configure
        
        override func configureViews() {
            super.configureViews()
            
            addSubview(titleLabel)
        }
        
        override func configureConstraints() {
            super.configureConstraints()
            
            titleLabel.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
        
        override func update() {
            super.update()
            
            titleLabel.text = title
        }
    }
}
