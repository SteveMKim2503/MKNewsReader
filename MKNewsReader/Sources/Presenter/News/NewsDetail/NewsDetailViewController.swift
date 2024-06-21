//
//  NewsDetailViewController.swift
//  MKNewsReader
//
//  Created by MK on 6/21/24.
//

import UIKit
import Combine
import WebKit

final class NewsDetailViewController: BaseViewController {
    
    // MARK: - Property
    
    private let viewModel: ViewModel
    private let viewHolder = ViewHolder()
    private var cancellableBag = Set<AnyCancellable>()
    
    // MARK: - Init
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewHolder.place(in: view)
        viewHolder.configureConstraints(for: view)
        
        bindWebView()
        bindOutput()
        
        viewModel.interaction.viewDidLoad.send(())
    }
    
    // MARK: - Bind
    
    private func bindWebView() {
        viewHolder.webView.navigationDelegate = self
    }
    
    private func bindOutput() {
        viewModel.output.title
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] title in
                self?.title = title
            })
            .store(in: &cancellableBag)
        
        viewModel.output.contentURL
            .receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .sink(receiveValue: { [weak self] contentURL in
                self?.loadURL(contentURL)
            })
            .store(in: &cancellableBag)
    }
}

// MARK: - Private func

private extension NewsDetailViewController {
    
    func loadURL(_ url: URL) {
        let request = URLRequest(url: url)
        viewHolder.webView.load(request)
    }
}

// MARK: - WKNavigationDelegate

extension NewsDetailViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        viewModel.interaction.webViewDidLoad.send(())
    }
}
