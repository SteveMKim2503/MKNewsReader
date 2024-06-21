//
//  NewsListViewController+NewsContentView.swift
//  MKNewsReader
//
//  Created by MK on 6/20/24.
//

import UIKit

extension NewsListViewController {
    
    final class NewsContentView: BaseView {
        
        // MARK: - Declaration
        
        struct Content {
            let imageURL: URL?
            let title: String?
            let publishedAtString: String?
            let titleColor: UIColor
        }
        
        // MARK: - Property
        
        var content: Content? { didSet { update() }}
        
        // MARK: - View
        
        private lazy var contentView: UIView = {
            let view = UIView()
            view.layer.cornerRadius = 16.0
            view.layer.borderWidth = 1.0
            view.layer.borderColor = UIColor.gray.cgColor
            view.layer.masksToBounds = true
            return view
        }()
        private lazy var contentStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.spacing = 8.0
            stackView.alignment = .center
            return stackView
        }()
        private lazy var imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()
        private lazy var textContentStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.spacing = 4.0
            stackView.alignment = .leading
            return stackView
        }()
        private lazy var titleLabel: UILabel = {
            let label = UILabel()
            label.font = .boldSystemFont(ofSize: 12)
            label.numberOfLines = 2
            return label
        }()
        private lazy var publishedAtLabel: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 10)
            label.textColor = .lightGray
            label.numberOfLines = 1
            return label
        }()
        
        // MARK: - Configure
        
        override func configureViews() {
            super.configureViews()
            
            addSubview(contentView)
            
            contentView.addSubview(contentStackView)
            
            contentStackView.addArrangedSubview(imageView)
            contentStackView.addArrangedSubview(textContentStackView)
            
            textContentStackView.addArrangedSubview(titleLabel)
            textContentStackView.addArrangedSubview(publishedAtLabel)
        }
        
        override func configureConstraints() {
            super.configureConstraints()
            
            contentView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            contentStackView.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(8.0)
            }
            
            imageView.snp.makeConstraints { make in
                make.height.equalTo(44.0)
                make.width.equalTo(imageView.snp.height).multipliedBy(4.0/3.0)
            }
        }
        
        override func update() {
            super.update()
            
            imageView.setImage(with: content?.imageURL)
            titleLabel.text = content?.title
            publishedAtLabel.text = content?.publishedAtString
            titleLabel.textColor = content?.titleColor ?? .darkGray
        }
    }
}
