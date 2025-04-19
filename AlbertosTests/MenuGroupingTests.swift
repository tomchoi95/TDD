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
    func testEmptyMenuReturnsEmptySections() {}
    
    // 하나의 카테고리만 있는 배열을 주었을 때, 하나의 섹현으로 뭉쳐서 반환이 되는지 확인.
    func testMenuWithOneCategoryReturnsOneSection() {}
    
    // 많은 카테고리를 주고 그 카테고리가 알파벳 역순으로 리턴하는지 확인.
    func testMenuWithManyCategoriesReturnsManySectionsInReverseAlphabeticalOrder() {}
}
