//
//  MenuFetchingPlaceholder.swift
//  Albertos
//
//  Created by 최범수 on 2025-04-19.
//

import Foundation
import Combine

class MenuFetchingPlaceholder: MenuFetching {
    func fetchMenuAsync() async -> [MenuItem] {
        try? await Task.sleep(nanoseconds: 500_000_000) // 0.5초 대기
        
        return menu
    }
    
    func fetchMenu() -> AnyPublisher<[MenuItem], Error> {
        
        return Future<[MenuItem], Error> { [weak self] promise in
            guard let self else { promise(.failure(NSError(domain: "", code: 0, userInfo: nil))); return }
            Task {
                let menu = await self.fetchMenuAsync()
                promise(.success(menu))
            }
        }
        .eraseToAnyPublisher()
    }
}
