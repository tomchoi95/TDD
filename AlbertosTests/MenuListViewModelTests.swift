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
    var cancellables = Set<AnyCancellable>()
    
    // grouping function이 잘 불려지는지 spyClosure를 대신 넣어보고 확인하기.
    
    /*
    func testCallsGivenGroupingFunction() {
        var isCalled = false
        let inputSections = [MenuSection.fixture()]
        let spyClosure: ([MenuItem]) -> [MenuSection] = { menuItems in
            print("spy closure: \(menuItems)")
            isCalled = true
            return inputSections
        }
        let viewModel = MenuList.ViewModel(menuFetching: MenuFetchingPlaceholder(), menuGrouping: spyClosure)
        let sections = viewModel.sections
        
        XCTAssertTrue(isCalled)
        XCTAssertEqual(sections, inputSections)
    }
    */
    
    // 비동기로 패치가 성공하고, 그로 인해 섹션이 잘 만들어지는지.
    func testWhenFetchingSucceedsPublishesSectionsBuiltFromReceivedMenu() {
        let expectedSections = groupMenuByCategory(menu)
        let menuFetching = MenuFetchingStub(result: .success(menu))
        let expectation = XCTestExpectation(description: "Publishes sections")
        let viewModel = MenuList.ViewModel(menuFetching: menuFetching)
        
        viewModel.$sections
            .dropFirst()
            .sink(receiveValue: { menuSections in
                XCTAssertEqual(menuSections, expectedSections)
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }
}
