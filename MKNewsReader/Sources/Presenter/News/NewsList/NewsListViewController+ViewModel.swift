//
//  NewsListViewController+ViewModel.swift
//  MKNewsReader
//
//  Created by MK on 6/20/24.
//

import UIKit
import Combine

extension NewsListViewController {
    
    struct Payload {
    }
    
    struct Dependency {
        let newsRepository: NewsRepositoryProtocol
    }
    
    struct Interaction {
        let viewDidLoad = PassthroughSubject<Void, Never>()
        let pullToRefresh = PassthroughSubject<Void, Never>()
        let newsContentSelected = PassthroughSubject<UUID, Never>()
    }
    
    struct Output {
        let title = Just("News")
        let sections = CurrentValueSubject<[NewsListSectionType], Never>([])
        
        let moveToNewsDetail = PassthroughSubject<UUID, Never>()
    }
}

extension NewsListViewController {
    
    final class ViewModel {
        
        // MARK: - Property
        
        let interaction = Interaction()
        let output = Output()
        let dependency: Dependency
        
        private let payload: Payload
        private var cancellableBag = Set<AnyCancellable>()
        private let maxItemCountPerLineForLandscape: Int = 5
        
        private var newsContentSectionIndex: Int? {
            return output.sections.value.firstIndex(where: { sectionType in
                switch sectionType {
                case .newsContent:
                    return true
                default:
                    return false
                }
            })
        }
        
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
                .map(makeSections(with:))
                .assign(to: \.value, on: output.sections)
                .store(in: &cancellableBag)
        }
        
        private func bindInteraction() {
            Publishers
                .Merge(
                    interaction.viewDidLoad,
                    interaction.pullToRefresh
                )
                .sink(receiveValue: { [weak self] _ in
                    self?.dependency.newsRepository.fetchTopHeadlineNews()
                })
                .store(in: &cancellableBag)
            
            interaction.newsContentSelected
                .sink(receiveValue: { [weak self] id in
                    self?.output.moveToNewsDetail.send(id)
                })
                .store(in: &cancellableBag)
        }
        
        // MARK: - Private Function
        
        private func makeSections(with newsContents: [NewsContent]) -> [NewsListSectionType] {
            var sections: [NewsListSectionType] = []
            sections.append(.header("Korean Top Headline News"))
            
            var contents: [NewsContent] = []
            for content in newsContents {
                contents.append(content)
                if contents.count == maxItemCountPerLineForLandscape {
                    sections.append(.newsContent(contents))
                    contents.removeAll()
                }
            }
            if !contents.isEmpty {
                sections.append(.newsContent(contents))
            }
            
            return sections
        }
    }
}
