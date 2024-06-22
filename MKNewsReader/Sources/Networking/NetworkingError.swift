//
//  NetworkingError.swift
//  MKNewsReader
//
//  Created by MK on 6/18/24.
//

import Foundation
import Alamofire

/// errors related to networking operations
enum NetworkingError: Error {
    /// error related to URL issues such as malformed URLs or network connectivity problems
    case urlError(URLError)
    /// error encountered while decoding the response data
    case decodingError(Error)
    /// errors specific to Alamofire's network request operations
    case networkError(AFError)
    /// unknown error that does not fit into the other categories
    case unknownError(Error?)
}

extension NetworkingError: CustomNSError {
    static var errorDomain: String { "com.MK.MKNewsReader.error.networking" }
    
    var errorCode: Int {
        switch self {
        case .urlError:
            return -1000
        case .decodingError:
            return -1001
        case .networkError:
            return -1002
        case .unknownError:
            return -1003
        }
    }
    
    var errorUserInfo: [String : Any] {
        var userInfo: [String: Any] = [:]
        
        switch self {
        case .urlError(let urlError):
            userInfo[NSUnderlyingErrorKey] = urlError
        case .decodingError(let error):
            userInfo[NSUnderlyingErrorKey] = error
        case .networkError(let afError):
            userInfo[NSUnderlyingErrorKey] = afError
        case .unknownError(let error):
            userInfo[NSUnderlyingErrorKey] = error
        }
        
        return userInfo
    }
}

extension NetworkingError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .urlError(let urlError):
            return urlError.localizedDescription
        case .decodingError(let error):
            return error.localizedDescription
        case .networkError(let afError):
            return afError.localizedDescription
        case .unknownError(let error):
            return error?.localizedDescription
        }
    }
}
