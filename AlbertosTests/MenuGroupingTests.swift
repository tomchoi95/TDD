//
//  MenuGroupingTests.swift
//  AlbertosTests
//
//  Created by 최범수 on 2025-04-19.
//

import Foundation
import XCTest

@testable import Albertos

class MenuGroupingTests: XCTestCase {
    // 빈 메뉴 아이템 배열을 받으면 빈 섹션을 리턴함. 그것을 테스트 하는 것.
    func testEmptyMenuReturnsEmptySections() {
        // Arrange
        let menu = [MenuItem]() // 빈 베뉴 아이템 배열을 세팅
        
        // Act
        let section: [MenuSection] = groupMenuByCategory(menu) // groupMenuByCategory함수를 만들지 않고 테스트 시나리오 작성. 이 함수는 메뉴 아이템들을 섹션으로 분리해서 return할 예정.
        
        // Assert
        XCTAssertTrue(section.isEmpty, "배열이 비어있는지 확인.")
    }
    
    // 하나의 카테고리만 있는 배열을 주었을 때, 하나의 섹현으로 뭉쳐서 반환이 되는지 확인.
    func testMenuWithOneCategoryReturnsOneSection() throws {
        // Arrange
        let menu = [
            MenuItem.fixture(category: "pastas", name: "a pasta"),
            MenuItem.fixture(category: "pastas", name: "another pasta"),
        ]
        
        // Act
        let sections: [MenuSection] = groupMenuByCategory(menu) // 하나의 섹션만 존재하는 배열을 넣었을 때, 하나의 섹션만 반환하는지 확인하는 코드
        
        // Assert
        let section: MenuSection = try XCTUnwrap(sections.first)
        XCTAssertEqual(sections.count, 1, "섹션의 개수를 확인.")
        // 섹션의 이름이 pastas를 갖는지
        XCTAssertEqual(section.category, "pastas")
        // 섹션의 아이템 카운트가 2인지.
        XCTAssertEqual(section.items.count, 2, "섹션의 아이템의 개수를 확인")
        // 섹선의 아이템의 이름이 잘 나오는지.
        XCTAssertEqual(section.items.first?.name, "a pasta", "섹션 아이템의 이름이 a pasta인지 확인.")
        XCTAssertEqual(section.items.last?.name, "another pasta", "섹션 아이템의 이름이 another pasta인지 확인.")
    }
    
    // 많은 카테고리를 주고 그 카테고리가 알파벳 역순으로 리턴하는지 확인.
    func testMenuWithManyCategoriesReturnsManySectionsInReverseAlphabeticalOrder() {
        // Arrange
        let menu = [
            MenuItem.fixture(category: "pastas", name: "a pasta"),
            MenuItem.fixture(category: "drinks", name: "a drink"),
            MenuItem.fixture(category: "pastas", name: "another pasta"),
            MenuItem.fixture(category: "desserts", name: "a dessert"),
        ]
        
        // Act
        let sections: [MenuSection] = groupMenuByCategory(menu)
        
        // Assert
        // 배열의 n번째에 접근시, 범위가 넘는 값을 주었을 때, fatal Error 발생하므로, 값이 있다면 return, 없다면 nill을 반환하게 하는 subscript를 만들어 주자.
        XCTAssertEqual(sections.count, 3)
        XCTAssertEqual(sections[safe: 0]?.category, "pastas")
        XCTAssertEqual(sections[safe: 1]?.category, "drinks")
        XCTAssertEqual(sections[safe: 2]?.category, "desserts")
    }
}
