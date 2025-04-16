//
//  MenuItemTests.swift
//  AlbertosTests
//
//  Created by 최범수 on 2025-04-16.
//

import XCTest
@testable import Albertos

final class MenuItemTests: XCTestCase {

    func testWhenDecodedFromJSONDataHasAllTheInputProperties() throws {
        let json = #"{ "name": "a name", "category": "a category", "spicy": true, "price": 100 }"#
        let data = try XCTUnwrap(json.data(using: .utf8))
        let item = try JSONDecoder().decode(MenuItem.self, from: data)
        XCTAssertEqual(item.name, "a name")
        XCTAssertEqual(item.category, "a category")
        XCTAssertEqual(item.spicy, true)
    }

}
