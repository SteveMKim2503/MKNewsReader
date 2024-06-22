//
//  APIPublisher.swift
//  MKNewsReader
//
//  Created by MK on 6/19/24.
//

import Foundation
import Combine

typealias APIPublisher<T: Decodable> = AnyPublisher<T, NetworkingError>
