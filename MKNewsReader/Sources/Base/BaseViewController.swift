//
//  BaseViewController.swift
//  MKNewsReader
//
//  Created by MK on 6/21/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        navigationItem.backButtonTitle = ""
    }
}
