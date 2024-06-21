//
//  NewsListViewController.swift
//  MKNewsReader
//
//  Created by MK on 6/20/24.
//

import UIKit
import Combine

final class NewsListViewController: UIViewController {
    
    // MARK: - Private Property
    
    private let viewModel: ViewModel
    private let viewHolder = ViewHolder()
    private let newsListCollectionViewAdepter = NewsListCollectionViewAdapter()
    private lazy var newsListCollectionViewLayout: UICollectionViewLayout = makeCompositionalLayout()
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
        
        bindCollectionView()
        bindCollectionViewLayout()
        bindInteraction()
        bindOutput()
        
        viewModel.interaction.viewDidLoad.send(())
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate { _ in
            self.bindCollectionViewLayout()
        }
    }
    
    // MARK: - Bind
    
    private func bindCollectionView() {
        viewHolder.newsListCollectionView.dataSource = newsListCollectionViewAdepter
        viewHolder.newsListCollectionView.delegate = newsListCollectionViewAdepter
    }
    
    private func bindCollectionViewLayout() {
        viewHolder.newsListCollectionView.setCollectionViewLayout(newsListCollectionViewLayout, animated: false)
    }
    
    private func bindInteraction() {
        newsListCollectionViewAdepter.newsContentSelected
            .sink(receiveValue: { [weak self] id in
                self?.viewModel.interaction.newsContentSelected.send(id)
            })
            .store(in: &cancellableBag)
    }
    
    private func bindOutput() {
        viewModel.output.sections
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] sections in
                self?.newsListCollectionViewAdepter.sections = sections
                self?.viewHolder.newsListCollectionView.reloadData()
            })
            .store(in: &cancellableBag)
        
        viewModel.output.moveToNewsDetail
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] id in
                self?.moveToNewsDetail(with: id)
            })
            .store(in: &cancellableBag)
    }
}

// MARK: - Navigating

private extension NewsListViewController {
    
    func moveToNewsDetail(with id: UUID) {
        // TODO: -
    }
}

// MARK: - Private Function

private extension NewsListViewController {
    
    func makeCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        
        return UICollectionViewCompositionalLayout(
            sectionProvider: { [weak self] (offset, _) -> NSCollectionLayoutSection?  in
                guard let section = self?.viewModel.output.sections.value[safe: offset] else { return nil }
                
                switch section {
                case .header:
                    return self?.makeHeaderSectionLayout()
                    
                case .newsContent:
                    if UIDevice.current.orientation.isLandscape {
                        return self?.makeNewsContentSectionLayoutForLandscape()
                    } else {
                        return self?.makeNewsContentSectionLayoutForPortrait()
                    }
                }
            },
            configuration: configuration
        )
    }
    
    func makeHeaderSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(30)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(30)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 20.0,
            leading: 16.0,
            bottom: 0.0,
            trailing: 16.0
        )
        return section
    }
    
    func makeNewsContentSectionLayoutForPortrait() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(120.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(120.0)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 10.0,
            leading: 16.0,
            bottom: 0,
            trailing: 16.0
        )
        section.interGroupSpacing = 10.0
        return section
    }
    
    func makeNewsContentSectionLayoutForLandscape() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(300.0),
            heightDimension: .absolute(120.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .estimated(300.0 * 5),
            heightDimension: .absolute(120.0)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            repeatingSubitem: item,
            count: 5
        )
        group.interItemSpacing = .fixed(10.0)
        
        let parentGroupSize = NSCollectionLayoutSize(
            widthDimension: .estimated(300.0 * 5),
            heightDimension: .estimated(1000)
        )
        
        let parentGroup = NSCollectionLayoutGroup.vertical(layoutSize: parentGroupSize, subitems: [group])
        parentGroup.interItemSpacing = .fixed(20.0)
        
        let section = NSCollectionLayoutSection(group: parentGroup)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 10.0,
            leading: 16.0,
            bottom: 0,
            trailing: 16.0
        )
        section.interGroupSpacing = 30.0
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
}
