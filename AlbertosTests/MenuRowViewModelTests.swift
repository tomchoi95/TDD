//
//  MenuRowViewModelTests.swift
//  AlbertosTests
//
//  Created by 최범수 on 2025-04-19.
//

import XCTest

@testable import Albertos

final class MenuRowViewModelTests: XCTestCase {
    // 뷰모델에서 안매운거 들어갔을 때 로우에서 이름만 출력되는지.
    func testWhenItemIsNotSpicyTextIsItemNameOnly() {
        // Arrange
        let item = MenuItem.fixture(name: "name", spicy: false)
        let viewModel = MenuRow.ViewModel(item: item)
        
        // Assert
        XCTAssertEqual(viewModel.text, "name")
    }
    
    // 뷰모델에서 매운거 들어갔을 때 로우에서 끝에 이모지가 붙어서 나오는지.
    func testWhenItemIsSpicyTextIsItemNameWithChiliEmoji() {
        // Arrange
        let item = MenuItem.fixture(name: "spicy name", spicy: true)
        let viewModel = MenuRow.ViewModel(item: item)
        
        // Assert
        XCTAssertEqual(viewModel.text, "spicy name 🌶️")
    }
}
