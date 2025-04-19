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
        let json = """
            {
                "name": "a name",
                "category": "a category",
                "spicy": true,
                "price": 1.0,
                "description": "a description"
            }
            """.data(using: .utf8)!
        
        let item = try JSONDecoder().decode(MenuItem.self, from: json)
        
        XCTAssertEqual(item.name, "a name")
        XCTAssertEqual(item.category, "a category")
        XCTAssertEqual(item.spicy, true)
        XCTAssertEqual(item.price, 1.0)
        XCTAssertEqual(item.description, "a description")
    }
    
    func testDecodesFromJSONData() throws {
        let json = """
            {
                "name": "a name",
                "category": "a category",
                "spicy": true,
                "price": 1.0,
                "description": "a description"
            }
            """.data(using: .utf8)!
        
        let item = try JSONDecoder().decode(MenuItem.self, from: json)
        
        XCTAssertEqual(item.name, "a name")
        XCTAssertEqual(item.category, "a category")
        XCTAssertEqual(item.spicy, true)
        XCTAssertEqual(item.price, 1.0)
        XCTAssertEqual(item.description, "a description")
    }
    
}

extension XCTestCase {
    func dataFromJSONFileNamed(_ name: String) throws -> Data {
        let url = try XCTUnwrap(
            Bundle(for: type(of: self)).url(forResource: name, withExtension: "json")
        )
        return try Data(contentsOf: url)
    }
}
