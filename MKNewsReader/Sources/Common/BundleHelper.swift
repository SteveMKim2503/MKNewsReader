//
//  BundleHelper.swift
//  MKNewsReader
//
//  Created by MK on 6/19/24.
//

import Foundation

/// helper for getting value from bundle
struct BundleHelper {
    
    // MARK: - Property
    
    private let bundle: Bundle
    
    // MARK: - Init
    
    init(bundle: Bundle = Bundle.main) {
        self.bundle = bundle
    }
    
    // MARK: - Public Function
    
    /// fetch string from bundle using key
    func fetchStringFromBundle(using key: String) -> String? {
        return bundle.infoDictionary?[key] as? String
    }
}
