//
//  MenuFetching.swift
//  Albertos
//
//  Created by 최범수 on 2025-04-19.
//

import Foundation
import Combine

protocol MenuFetching {
    func fetchMenu() -> AnyPublisher<[MenuItem], Error>
}

// 네트워크 통신 실패를 내가 임의로 값을 보낼 수 있게 하는 Stub 객체.
class MenuFetchingStub: MenuFetching {
    private var result: Result<[MenuItem], Error>
    
    init(result: Result<[MenuItem], Error>) {
        self.result = result
    }
    
    func fetchMenu() -> AnyPublisher<[MenuItem], Error> {
        result.publisher
            .delay(for: 0.1, scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
}

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
