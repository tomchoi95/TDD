//
//  NetworkFetchingStub.swift
//  Albertos
//
//  Created by 최범수 on 2025-04-16.
//

import Foundation
import Combine

class NetworkFetchingStub: NetworkFetching {
    private let result: Result<Data, URLError>
    
    init(returning result: Result<Data, URLError>) {
        self.result = result
    }
    
    func load(_ request: URLRequest) -> AnyPublisher<Data, URLError> {
        return result.publisher
            .delay(for: 0.1, scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    
}

// 이 클래스는 stub(찔러보기) 용도임.
// 그래서 성공 및 실패를 정해놓고 테스트를 해줄 수 있음.
// 네트워트 통신 하는 '척'해주는 코드.
