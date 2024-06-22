//
//  ManagedEnvironmentKeys.swift
//  MKNewsReader
//
//  Created by MK on 6/19/24.
//

import Foundation

/// enviroment keys managed on service
struct ManagedEnvironmentKeys {
    
    // MARK: - Property
    
    /// api key for NewsAPI
    var newsAPIKey: String? {
        return bundleHelper.fetchStringFromBundle(using: "NEWS_API_KEY")
    }
    
    // MARK: - Private Property
    
    private let bundleHelper: BundleHelper
    
    // MARK: - Init
    
    init(bundleHelper: BundleHelper = BundleHelper()) {
        self.bundleHelper = bundleHelper
    }
}
