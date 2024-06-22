//
//  BaseViewController.swift
//  MKNewsReader
//
//  Created by MK on 6/21/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    deinit {
        print("\(String(describing: type(of: self))) : deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        navigationItem.backButtonTitle = ""
    }
}
