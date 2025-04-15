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
    func fetchMenu() -> AnyPublisher<[MenuItem], any Error> {
        return Future { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { promise(.success(.mockItems)) }
            
        }.eraseToAnyPublisher()
    }
}
