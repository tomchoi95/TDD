//
//  MenuFetcherTests.swift
//  AlbertosTests
//
//  Created by 최범수 on 2025-04-17.
//

import Foundation
import Combine
@testable import Albertos
import XCTest

class MenuFetcherTests: XCTestCase {
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        cancellables = []
    }
    
    override func tearDown()  {
        cancellables = nil
        super.tearDown()
    }
    
    func testWhenRequestSucceedsPublishesDecodedMenuItems() {
        let expectation = XCTestExpectation(description: "Publishes decoded [MenuItem]")
        let menuFetcher = MenuFetcher()
        
        menuFetcher.fetchMenu()
            .sink(receiveCompletion: { _ in },
                  receiveValue: { items in
                    XCTAssertEqual(items.count, 8)
                    expectation.fulfill()
                  })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5.0)  // 타임아웃을 5초로 증가
    }
    
    func testWhenRequestFailsPublishesReceivedError() {
        let expected = URLError(.badServerResponse)
        let stub = NetworkFetchingStub(returning: .failure(expected))
        let menuFetcher = MenuFecther(networkFetching: stub)
        
        let expectation = XCTestExpectation(description: "Publishes received URLError")
        
        menuFetcher.fetchMenu()
            .sink { completion in
                guard case .failure(let error) = completion else { return }
                XCTAssertEqual(error as? URLError, expected)
                expectation.fulfill()
            } receiveValue: { items in
                XCTFail("Expected to fail, succeeded with\(items)")
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }
}
