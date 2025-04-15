//
//  AlbertosTests.swift
//  AlbertosTests
//
//  Created by 최범수 on 2025-04-14.
//

import XCTest
@testable import Albertos

final class AlbertosTests: XCTestCase {
    // 빈 배열이 주어졌을 때, 빈 섹션 배열을 반환하는지 확인.
    func testEmptyMenuReturnsEmptySections() {
        let menu = [MenuItem]()
        let sections = groupMenuByCategory(menu)
        XCTAssertTrue(sections.isEmpty)
    }
    
    // 하나의 카테고리에 속한 메뉴 항목들이 주어졌을 때, 하나의 섹션만 반환되는지 확인.
    func testMenuWithOneCategoryReturnsOneSection() throws {
        let menu = [
            MenuItem.fixture(category: "pastas", name: "name"),
            MenuItem.fixture(category: "pastas", name: "other name")
        ]
        let sections = groupMenuByCategory(menu)
        XCTAssertEqual(sections.count, 1)
        let section = try XCTUnwrap(sections.first)
        XCTAssertEqual(section.items.count, 2)
        XCTAssertEqual(section.items.first?.name, "name")
        XCTAssertEqual(section.items.last?.name, "other name")
    }
    
    // 여러 카테고리에 속한 메뉴 항목들이 주어졌을 때, 카테고리 수만큼 섹션이 생성이 되었는지 확인.
    func testMenuWithManyCategoriesReturnsManySectionsInReverseAlphabeticalOrder() {
        let menu = [
            MenuItem.fixture(category: "pastas",name: "a pasta"),
            MenuItem.fixture(category: "drinks",name: "a drink"),
            MenuItem.fixture(category: "pastas",name: "another pasta"),
            MenuItem.fixture(category: "desserts",name: "a dessert")
        ]
        let sections = groupMenuByCategory(menu)
        XCTAssertEqual(sections.count, 3)
        XCTAssertEqual(sections[safe: 0]?.category, "pastas")
        XCTAssertEqual(sections[safe: 1]?.category, "drinks")
        XCTAssertEqual(sections[safe: 2]?.category, "desserts")
    }
    
    func testWhenItemIsNotSpicyTextIsItemNameOnly() {
        let item = MenuItem.fixture(name: "name", spicy: false)
        let viewModel = MenuRow.ViewModel(item: item)
        XCTAssertEqual(viewModel.text, "name")
    }
    
    func testWhenItemIsSpicyTextIsItemNameWithChiliEmoji() {
        let item = MenuItem.fixture(name: "name", spicy: true)
        let viewModel = MenuRow.ViewModel(item: item)
        XCTAssertEqual(viewModel.text, "🌶️ name")
    }
}
