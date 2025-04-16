//
//  URLSession+NetworkFetching.swift
//  Albertos
//
//  Created by 최범수 on 2025-04-16.
//

import Foundation
import Combine

extension URLSession: NetworkFetching {
    func load(_ request: URLRequest) -> AnyPublisher<Data, URLError> {
        return dataTaskPublisher(for: request)
            .map { $0.data }
            .eraseToAnyPublisher()
    }
    
}
