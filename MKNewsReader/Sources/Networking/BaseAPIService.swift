//
//  BaseAPIService.swift
//  MKNewsReader
//
//  Created by MK on 6/18/24.
//

import Foundation
import Combine
import Alamofire

class BaseAPIService {
    
    private let baseURL: URL = {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "newsapi.org"
        guard let url = urlComponents.url else { fatalError("Generating server endpoint components has failed") }
        return url
    }()
    
    func request<T: Decodable>(
        api: API,
        header: HTTPHeaders? = nil,
        type: T.Type
    ) -> APIPublisher<T> {
        return request(
            url: baseURL.appendingPathComponent(api.path),
            method: api.method,
            parameters: api.parameters,
            header: header,
            type: type
        )
    }
    
    func request<T: Decodable>(
        url: URL,
        method: HTTPMethod,
        parameters: [String: Encodable]?,
        header: HTTPHeaders? = nil,
        type: T.Type
    ) -> APIPublisher<T> {
        return AF.request(
            url,
            method: method,
            parameters: parameters,
            encoding: method.encoding,
            headers: header
        )
        .publishDecodable(type: type)
        .tryMap { dataResponse -> T in
            if let error = dataResponse.error {
                throw NetworkingError.networkError(error)
            }
            guard let value = dataResponse.value else {
                throw NetworkingError.unknownError(nil)
            }
            
            return value
        }
        .mapError { error -> NetworkingError in
            switch error {
            case let afError as AFError:
                return .networkError(afError)
            case let urlError as URLError:
                return .urlError(urlError)
            case let networkingError as NetworkingError:
                return networkingError
            case let decodingError as DecodingError:
                return .decodingError(decodingError)
            default:
                return .unknownError(error)
            }
        }
        .eraseToAnyPublisher()
    }
}

extension Alamofire.HTTPMethod {
    var encoding: ParameterEncoding { self == .get ? URLEncoding.default : JSONEncoding.default }
}
