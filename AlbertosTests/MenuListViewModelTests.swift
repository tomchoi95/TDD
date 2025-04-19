//
//  MenuListViewModelTests.swift
//  AlbertosTests
//
//  Created by 최범수 on 2025-04-19.
//

import XCTest

@testable import Albertos

final class MenuListViewModelTests: XCTestCase {
    // grouping function이 잘 불려지는지 spyClosure를 대신 넣어보고 확인하기.
    func testCallsGivenGroupingFunction() {
        var isCalled = false
        let inputSections = [MenuSection.fixture()]
        let spyClosure: ([MenuItem]) -> [MenuSection] = { menuItems in
            print("spy closure: \(menuItems)")
            isCalled = true
            return inputSections
        }
        let viewModel = MenuList.ViewModel(menu: [.fixture()], menuGrouping: spyClosure)
        let sections = viewModel.sections
        
        XCTAssertTrue(isCalled)
        XCTAssertEqual(sections, inputSections)
    }
}
