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
                MenuItem(category: "starters", name: "Caprese Salad", spicy: false, price: 9.99),
                MenuItem(category: "starters", name: "Arancini Balls", spicy: false, price: 8.49)
            ]),
            MenuSection(category: "pastas", items: [
                MenuItem(category: "pastas", name: "Penne all'Arrabbiata", spicy: true, price: 11.99),
                MenuItem(category: "pastas", name: "Spaghetti Carbonara", spicy: false, price: 12.49)
            ]),
            MenuSection(category: "drinks", items: [
                MenuItem(category: "drinks", name: "Water", spicy: false, price: 1.99),
                MenuItem(category: "drinks", name: "Red Wine", spicy: false, price: 4.99)
            ]),
            MenuSection(category: "desserts", items: [
                MenuItem(category: "desserts", name: "Tiramisù", spicy: false, price: 5.99),
                MenuItem(category: "desserts", name: "Crema Catalana", spicy: false, price: 5.49)
            ])
        ]
        let menuFetching = MenuFetchingStub(result: .success(menu))
        let expectation = XCTestExpectation(description: "Publishes sections")
        let viewModel = MenuListViewModel(menuFetching: menuFetching)
        
        viewModel.$sections
            .dropFirst()
            .sink { result in
                guard case .success(let sections) = result else {
                    return XCTFail("Expected a successful Result, got: \(result)")
                }
                XCTAssertEqual(sections, expectedSections)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
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
    
//    func testWhenFetchingFailsPublishesAnError() {
//        let expectedError: TestError = .init(id: 123)
//        let expectation = XCTestExpectation(description: "Waiting for menu to be fetched")
//        
//        let menuFetchingStub = MenuFetchingStub { () -> AnyPublisher<[MenuItem], Error> in
//            Fail(error: expectedError)
//                .delay(for: 0.1, scheduler: RunLoop.main)  // 비동기 작업을 위한 지연 추가
//                .eraseToAnyPublisher()
//        }
//        
//        let viewModel = MenuListViewModel(menuFetching: menuFetchingStub, menuGrouping: { _ in [] })
//        
//        viewModel.$sections
//            .dropFirst()  // 초기 상태(.success([]))를 건너뛰기
//            .sink { result in
//                guard case .failure(let error) = result else {
//                    return XCTFail("Expected a failing Result, got: \(result)")
//                }
//                XCTAssertEqual(error as? TestError, expectedError)
//                expectation.fulfill()
//            }
//            .store(in: &cancellables)
//        
//        wait(for: [expectation], timeout: 1)
//    }
    
    func testRetryFetchesMenuAgain() {
        let expectation = XCTestExpectation(description: "Fetches menu twice")
        expectation.expectedFulfillmentCount = 2
        
        var fetchCount = 0
        let stubbedMenu = [MenuItem.fixture()]
        
        let menuFetchingStub = MenuFetchingStub { () -> AnyPublisher<[MenuItem], Error> in
            fetchCount += 1
            expectation.fulfill()
            return Just(stubbedMenu)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        let viewModel = MenuListViewModel(menuFetching: menuFetchingStub)
        viewModel.retry()
        
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(fetchCount, 2)
    }
}

class MenuFetchingStub: MenuFetching {
    let result: Result<[MenuItem], Error>
    let fetchClosure: (() -> AnyPublisher<[MenuItem], Error>)?
    
    init(result: Result<[MenuItem], Error>) {
        self.result = result
        self.fetchClosure = nil
    }
    
    init(fetchClosure: @escaping () -> AnyPublisher<[MenuItem], Error>) {
        self.result = .success([])
        self.fetchClosure = fetchClosure
    }
    
    func fetchMenu() -> AnyPublisher<[MenuItem], Error> {
        if let closure = fetchClosure {
            return closure()
        }
        return result.publisher
            .delay(for: 0.1, scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
}

struct TestError: Equatable, Error {
    let id: Int
}
