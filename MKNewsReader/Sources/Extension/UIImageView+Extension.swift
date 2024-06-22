//
//  UIImageView+Extension.swift
//  MKNewsReader
//
//  Created by MK on 6/20/24.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func setImage(with url: URL?) {
        kf.setImage(with: url)
    }
}
