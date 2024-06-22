//
//  BaseNavigationController.swift
//  MKNewsReader
//
//  Created by MK on 6/21/24.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        let appearance = navigationBar.standardAppearance
        appearance.configureWithOpaqueBackground()
        appearance.shadowColor = .black.withAlphaComponent(0.04)
        appearance.backgroundColor = .white
        appearance.backButtonAppearance = .init(style: .plain)
        
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.compactAppearance = appearance
        
        navigationBar.barTintColor = .white
        navigationBar.tintColor = .darkGray
    }
}
