//
//  AppDelegate+Kingfisher.swift
//  MKNewsReader
//
//  Created by MK on 6/22/24.
//

import Foundation
import Kingfisher

extension AppDelegate {
    
    func configureKingfisher() {
        ImageCache.default.diskStorage.config.sizeLimit = UInt(200 * 1024 * 1024) // 200MB
        ImageCache.default.memoryStorage.config.totalCostLimit = 100 * 1024 * 1024 // 100MB
    }
}
