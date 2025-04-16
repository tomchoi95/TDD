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
    
    func testWhenRequestSucceedsPublishesDecodedMenuItems() throws {
        let json =
            """
             [
                { "name": "a name", "category": "a category", "spicy": true },
                { "name": "another name", "category": "a category", "spicy": true }
             ] 
            """
        let data = try XCTUnwrap(json.data(using: .utf8))
        let stub = NetworkFetchingStub(returning: .success(data))
        let menuFetcher = MenuFecther(networkFetching: stub)
        
        let expectation = XCTestExpectation(description: "Publishes decoded [MenuItem]")
        
        menuFetcher.fetchMenu()
            .sink { completion in
                
            } receiveValue: { items in
                XCTAssertEqual(items.count, 2)
                XCTAssertEqual(items.first?.name, "name")
                XCTAssertEqual(items.last?.name, "another name")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }
}
