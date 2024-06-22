//
//  UICollectionView+Extension.swift
//  MKNewsReader
//
//  Created by MK on 6/20/24.
//

import UIKit

extension UICollectionView {
    
    func dequeueReusableCell<T: BaseCollectionViewCell>(withClass: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Cell is not registered to view")
        }
        return cell
    }
    
    func register(_ cellType: BaseCollectionViewCell.Type) {
        register(cellType, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
}
