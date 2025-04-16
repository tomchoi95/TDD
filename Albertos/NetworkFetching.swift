//
//  NetworkFetching.swift
//  Albertos
//
//  Created by 최범수 on 2025-04-16.
//

import Foundation
import Combine

protocol NetworkFetching {
    func load(_ request: URLRequest) -> AnyPublisher<Data, URLError>
}
