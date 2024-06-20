//
//  BaseView.swift
//  MKNewsReader
//
//  Created by MK on 6/20/24.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureViews()
        configureConstraints()
        update()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        configureViews()
        configureConstraints()
        update()
    }
    
    func configureViews() {}
    func configureConstraints() {}
    func update() {}
}
