//
//  API.swift
//  MKNewsReader
//
//  Created by MK on 6/19/24.
//

import Foundation
import Alamofire

/// protocol for networking API
protocol API {
    /// path for url component
    var path: String { get }
    /// HTTP request method
    var method: HTTPMethod { get }
    /// request parameters
    var parameters: [String: Encodable]? { get }
}
