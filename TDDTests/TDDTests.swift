//
//  TDDTests.swift
//  TDDTests
//
//  Created by 최범수 on 2025-04-14.
//

import XCTest
@testable import TDD

final class TDDTests: XCTestCase {
    
    func testFizzBuzzDivisibleBy3() {
        let test = fizzBuzz(3)
        let expected = "Fizz"
        XCTAssertEqual(test, expected)
    }
    
    func testFizzBuzzDivisibleBy5() {
        let test = fizzBuzz(5)
        let expected = "Buzz"
        XCTAssertEqual(test, expected)
    }
    
    func testFizzBuzzDivisibleBy15() {
        let test = fizzBuzz(15)
        let expected = "FizzBuzz"
        XCTAssertEqual(test, expected)
    }
    
    func testFizzBuzzNotDivisibleBy3Or5() {
        let test = fizzBuzz(2)
        let expected = "2"
        XCTAssertEqual(test, expected)
    }
}
