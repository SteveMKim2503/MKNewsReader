//
//  NewsDetailViewController+ViewHolder.swift
//  MKNewsReader
//
//  Created by MK on 6/21/24.
//

import UIKit
import WebKit

extension NewsDetailViewController {
    
    final class ViewHolder {
        
        // MARK: - View
        
        private(set) lazy var webView: WKWebView = {
            return WKWebView()
        }()
        
        // MARK: - Configure
        
        func place(in view: UIView) {
            view.addSubview(webView)
        }
        
        func configureConstraints(for view: UIView) {
            webView.snp.makeConstraints { make in
                make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
                make.bottom.equalToSuperview()
            }
        }
    }
}
