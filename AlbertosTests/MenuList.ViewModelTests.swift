//
//  MenuList.ViewModelTests.swift
//  AlbertosTests
//
//  Created by 최범수 on 2025-04-15.
//

import XCTest
import Combine

@testable import Albertos

final class MenuListViewModelTests: XCTestCase {
    var cancellables: Set<AnyCancellable> = []
    
    func testWhenFetchingSucceedsPublishesSectionsBuiltFromReceivedMenu() {
        let expectedSections = [
            MenuSection(category: "starters", items: [
                MenuItem(name: "Caprese Salad", category: "starters", spicy: false, price: 9.99),
                MenuItem(name: "Arancini Balls", category: "starters", spicy: false, price: 8.49)
            ]),
            MenuSection(category: "pastas", items: [
                MenuItem(name: "Penne all'Arrabbiata", category: "pastas", spicy: true, price: 11.99),
                MenuItem(name: "Spaghetti Carbonara", category: "pastas", spicy: false, price: 12.49)
            ]),
            MenuSection(category: "drinks", items: [
                MenuItem(name: "Water", category: "drinks", spicy: false, price: 1.99),
                MenuItem(name: "Red Wine", category: "drinks", spicy: false, price: 4.99)
            ]),
            MenuSection(category: "desserts", items: [
                MenuItem(name: "Tiramisù", category: "desserts", spicy: false, price: 5.99),
                MenuItem(name: "Crema Catalana", category: "desserts", spicy: false, price: 5.49)
            ])
        ]
        let menuFetching = MenuFetchingStub(result: .success(menu))
        let expectation = XCTestExpectation(description: "Publishes sections")
        let viewModel = MenuListViewModel(menuFetching: menuFetching)
        
        viewModel.$sections
            .dropFirst()
            .sink { sections in
                XCTAssertEqual(sections, expectedSections)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 0.1)
    }
}

class MenuFetchingStub: MenuFetching {
    let result: Result<[MenuItem], Error>
    
    init(result: Result<[MenuItem], Error>) {
        self.result = result
    }
    
    func fetchMenu() -> AnyPublisher<[MenuItem], Error> {
        return result.publisher
            .delay(for: 0.1, scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
