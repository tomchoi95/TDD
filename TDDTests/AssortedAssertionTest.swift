//
//  AssortedAssertionTest.swift
//  TDDTests
//
//  Created by 최범수 on 2025-04-14.
//

import XCTest

// Arrange, Act, Assert로 구분하자.

class AssortedAssertionTest: XCTestCase {
    func testAssertNil() {
        // Arrange
        let input: Int? = nil
        
        // Act && Assert
        XCTAssertNil(input, "input should be nil")
    }
    
    func testAssertNotNil() {
        // Arrange
        let input: Int? = 1
        
        // Act && Assert
        XCTAssertNotNil(input, "input should not be nil")
    }
    
    func testLessThan() {
        // Arrange
        let input: Int = 1
        let upperBount: Int = 2
        
        // Act && Assert
        XCTAssertLessThan(input, upperBount, "input should be less than 2")
    }
    
    // 실패 해 보기.
    func testGreaterThan() {
        // Arrange
        let input: Int = 3
        let upperBount: Int = 2
        
        // Act && Assert
        XCTAssertGreaterThan(input, upperBount, "\(input) should be greater than \(upperBount)")
    }
    
    func testLessThanOrEqualTo() {
        let input = 1
        let upperBound = 2
        
        XCTAssertLessThanOrEqual(input, upperBound, "\(input) should be less than or equal to \(upperBound)")
    }
    
    func testGreaterThanOrEqualTo() {
        let input = 4
        let upperBound = 2
        
        XCTAssertGreaterThanOrEqual(input, upperBound, "\(input) should be greater than or equal to \(upperBound)")
    }
    
    
    func testThrowsError() {
        func aFunctionThatThrowsAnError() throws -> Int {
            throw NSError(domain: "", code: 0, userInfo: nil)
        }
        
        XCTAssertThrowsError(try aFunctionThatThrowsAnError(), "Should throw an error")
    }
    
    func testNoThorw() {
        func aFunctionThatDoesNotThrowAnError() throws -> Int {
            return 1
        }
        
        XCTAssertNoThrow(try aFunctionThatDoesNotThrowAnError(), "Should not throw an error")
    }
}
