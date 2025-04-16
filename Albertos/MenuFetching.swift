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

class MenuFecther: MenuFetching {
    func fetchMenu() -> AnyPublisher<[MenuItem], any Error> {
        guard let url = URL(string: "https://raw.githubusercontent.com/mokagio/tddinswift_fake_api/trunk/menu_response.json") else {
            fatalError("Invalid URL")
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [MenuItem].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
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
