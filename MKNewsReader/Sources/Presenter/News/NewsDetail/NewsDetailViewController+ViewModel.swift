//
//  NewsDetailViewController+ViewModel.swift
//  MKNewsReader
//
//  Created by MK on 6/21/24.
//

import Foundation
import Combine

extension NewsDetailViewController {
    
    struct Payload {
        let newsContentID: UUID
    }
    
    struct Dependency {
        let newsRepository: NewsRepositoryProtocol
    }
    
    struct Interaction {
        let viewDidLoad = PassthroughSubject<Void, Never>()
        let webViewDidLoad = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        let title = CurrentValueSubject<String?, Never>(nil)
        let contentURL = PassthroughSubject<URL?, Never>()
    }
}

extension NewsDetailViewController {
    
    final class ViewModel {
        
        // MARK: - Property
        
        let interaction = Interaction()
        let output = Output()
        
        private let payload: Payload
        private let dependency: Dependency
        private var cancellableBag = Set<AnyCancellable>()
        private var newsContent: NewsContent?
        
        // MARK: - Init
        
        init(payload: Payload, dependency: Dependency) {
            self.payload = payload
            self.dependency = dependency
            
            bindRepository()
            bindInteraction()
        }
        
        // MARK: - Bind
        
        private func bindRepository() {
            dependency.newsRepository.newsContentsPublisher
                .compactMap { [weak self] newsContents in
                    return newsContents.first(where: { $0.id == self?.payload.newsContentID })
                }
                .sink(receiveValue: { [weak self] newsContent in
                    self?.output.title.send(newsContent.title)
                    self?.newsContent = newsContent
                })
                .store(in: &cancellableBag)
        }
        
        private func bindInteraction() {
            interaction.viewDidLoad
                .compactMap { [weak self] in self?.newsContent }
                .sink(receiveValue: { [weak self] newsContent in
                    self?.output.contentURL.send(newsContent.contentURL)
                })
                .store(in: &cancellableBag)
            
            interaction.webViewDidLoad
                .compactMap { [weak self] in self?.payload.newsContentID }
                .sink(receiveValue: { [weak self] id in
                    self?.dependency.newsRepository.updateAsRead(newsContentID: id)
                })
                .store(in: &cancellableBag)
        }
    }
}
