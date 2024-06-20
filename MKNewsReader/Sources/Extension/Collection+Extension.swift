//
//  Collection+Extension.swift
//  MKNewsReader
//
//  Created by MK on 6/20/24.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
