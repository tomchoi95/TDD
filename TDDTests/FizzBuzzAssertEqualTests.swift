//
//  TDDTests.swift
//  TDDTests
//
//  Created by 최범수 on 2025-04-14.
//

import XCTest
@testable import TDD

final class FizzBuzzAssertEqualTests: XCTestCase {
    
    func fizzBuzz(_ n: Int) -> String {
        switch (n % 3 == 0, n % 5 == 0) {
            case (false, false): "\(n)"
            case (true, false): "Fizz"
            case (false, true): "Buzz"
            case (true, true): "FizzBuzz"
        }
    }

    func asyncSum(a: Int, b: Int) async -> Int {
        try? await Task.sleep(for: .seconds(1))
        
        return a + b
    }
    
    func testFizzBuzzDivisibleBy3() {
        // given (준비)
        let input = 3
        
        // when (실행)
        let result = fizzBuzz(input)
        
        // then (검증)
        let expected = "Fizz"
        XCTAssertEqual(result, expected)
    }
    
    func testFizzBuzzDivisibleBy5() {
        // given (준비)
        let input = 5
        
        // when (실행)
        let result = fizzBuzz(input)
        
        // then (검증)
        let expected = "Buzz"
        XCTAssertEqual(result, expected)
    }
    
    func testFizzBuzzDivisibleBy15() {
        // given (준비)
        let input = 15
        
        // when (실행)
        let result = fizzBuzz(input)
        
        // then (검증)
        let expected = "FizzBuzz"
        XCTAssertEqual(result, expected)
    }
    
    func testFizzBuzzNotDivisibleBy3Or5() {
        // given (준비)
        let input = 2
        
        // when (실행)
        let result = fizzBuzz(input)
        
        // then (검증)
        let expected = "2"
        XCTAssertEqual(result, expected)
    }
    
    func testAsyncSum() async {
        let input1: Int = 1_000_000
        let input2: Int = 2_000_000
        
        let result = await asyncSum(a: input1, b: input2)
        
        let expected: Int = 3_000_000
        
        XCTAssertEqual(result, expected)
    }
}
