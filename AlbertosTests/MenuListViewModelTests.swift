//
//  MenuListViewModelTests.swift
//  AlbertosTests
//
//  Created by 최범수 on 2025-04-19.
//

import XCTest
import Combine

@testable import Albertos

final class MenuListViewModelTests: XCTestCase {
    var cancellables: Set<AnyCancellable> = []
    
    func testWhenFetchingStartsPublishesEmptyMenu() throws {
        let viewModel = MenuList.ViewModel(menuFetching: MenuFetchingStub(result: .success([])))
        let sections = try viewModel.sections.get()
        
        XCTAssertTrue(sections.isEmpty)
    }
    
    func testWhenFetchingSucceedsPublishesSectionsBuiltFromReceivedMenuAndGivenGroupingClosure() {
        var receivedMenu: [MenuItem]?
        let expectedSections: [MenuSection] = [.fixture()]
        let spyClosure: ([MenuItem]) -> [MenuSection] = { items in
            receivedMenu = items
            
            return expectedSections
        }
        let expectedMenu = [MenuItem.fixture()]
        let menuFetchingStub = MenuFetchingStub(result: .success(expectedMenu))
        let viewModel = MenuList.ViewModel(menuFetching: menuFetchingStub, menuGrouping: spyClosure)
        
        let expectation = XCTestExpectation(description: "Publishes sections built from received menu and given grouping closure")
        
        viewModel.$sections
            .dropFirst()
            .sink { result in
                guard case .success(let sections) = result else { XCTFail("Expected a successful Result, got \(result)"); return }
                XCTAssertEqual(receivedMenu, expectedMenu)
                XCTAssertEqual(sections, expectedSections)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testWhenFetchingFailsPublishesAnError() {
        let expectedError = NSError(domain: "Test", code: 123)
        let menuFetchingStub = MenuFetchingStub(result: .failure(expectedError))
        let viewModel = MenuList.ViewModel(menuFetching: menuFetchingStub)
        
        let expectation = XCTestExpectation(description: "Publishes an error")
        
        viewModel.$sections
            .dropFirst()
            .sink { result in
                guard case .failure(let error) = result else { XCTFail("Expected error, got: \(result)"); return }
                XCTAssertEqual(error as NSError, expectedError)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }
}
