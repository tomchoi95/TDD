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
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        cancellables = []
    }
    
    override func tearDown() {
        cancellables = nil
        super.tearDown()
    }
    
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
//                XCTAssertEqual(sections, expectedSections)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testWhenFetchingStartsPublishesEmptyMenu() throws {
        let viewModel = MenuListViewModel(menuFetching: MenuFetchingStub(result: .success([.fixture()])))
        let sections = try viewModel.sections.get()
        XCTAssertTrue(sections.isEmpty)
    }
    
    func testWhenFetchingSucceedsPublishesSectionsBuiltFromReceivedMenuAndGivenGroupingClosure() {
        var receivedMenu: [MenuItem]?
        let expectedSections = [MenuSection.fixture()]
        let spyClosure: ([MenuItem]) -> [MenuSection] = { items in
            receivedMenu = items
            return expectedSections
        }
        
        let expectedMenu = [MenuItem.fixture()]
        let menuFetchingStub = MenuFetchingStub(result: .success(expectedMenu))
        let viewModel = MenuListViewModel(menuFetching: menuFetchingStub, menuGrouping: spyClosure)
        let expectation = XCTestExpectation(description: "Waiting for menu to be fetched")
        
        viewModel.$sections
            .dropFirst()
            .sink { result in
                guard case .success(let sections) = result else {
                    return XCTFail("Expected a successful Result, got: \(result)")
                }
                XCTAssertEqual(receivedMenu, expectedMenu)
                XCTAssertEqual(sections, expectedSections)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testWhenFetchingFailsPublishesAnError() {
        let expectedError: TestError = .init(id: 123)
        let menuFetchingStub = MenuFetchingStub(result: .failure(expectedError))
        let viewModel = MenuListViewModel(menuFetching: menuFetchingStub, menuGrouping: { _ in [] })
        let expectation = XCTestExpectation(description: "Waiting for menu to be fetched")
        
        viewModel.$sections
            .sink { result in
                guard case .failure(let error) = result else {
                    return XCTFail("Expected a failing Result, got: \(result)")
                }
                XCTAssertEqual(error as? TestError, expectedError)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testRetryFetchesMenuAgain() {
        let expectation = XCTestExpectation(description: "Fetches menu twice, fails then succeeds")
        expectation.expectedFulfillmentCount = 2
        
        var fetchCount = 0
        let stubbedMenu = [MenuItem.fixture()]
//
//        let menuFetchingStub = MenuFetchingStub { () -> ANyPublisher<[MenuItem], Error> in
//            fetchCount += 1
//            expectation.fulfill()
//            return Just(stubbedMenu)
//                .setFailureType(to: Error.self)
//                .eraseToAnyPublisher()
//        }
        
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

struct TestError: Equatable, Error {
    let id: Int
}
