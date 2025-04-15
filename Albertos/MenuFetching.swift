//
//  MenuFetching.swift
//  Albertos
//
//  Created by 최범수 on 2025-04-15.
//

import Combine
import Foundation

protocol MenuFetching {
    func fetchMenu() -> AnyPublisher<[MenuItem], Error>
}

class MenuFetchingPlaceholder: MenuFetching {
    func fetchMenu() -> AnyPublisher<[MenuItem], Error> {
        Future { promise in
            Task {
                try await Task.sleep(nanoseconds: 1_000_000)
                promise(.success(.mockItems))
            }
        }
        .eraseToAnyPublisher()
    }
}
