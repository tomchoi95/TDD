//
//  XCTestExpectationTest.swift
//  TDDTests
//
//  Created by 최범수 on 2025-04-14.
//

import XCTest

class XCTestExpectationTest: XCTestCase {
    
    func asyncSum(a: Int, b: Int) async -> Int {
        try? await Task.sleep(for: .seconds(1))
        
        return a + b
    }
    
    func asyncSumOldSchool(_ a: Int, _ b: Int, completion: @escaping (Int) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.05) {
            completion(a + b)
        }
    }

    func testAsyncSum() async {
        // Arrange
        let input1 = 1
        let input2 = 2
        
        // Act
        let result = await asyncSum(a: input1, b: input2)
        
        // Assert
        let expected = 3
        
        XCTAssertEqual(result, expected)
    }
    
    func testAsyncSumOldSchool() {
        // Arrange
        let input1 = 1
        let input2 = 2
        
        // Assert
        let expectation = XCTestExpectation(description: "asyncSumOldSchool sum completed")
        
        // Act
        asyncSumOldSchool(input1, input2) { sum in
            XCTAssertEqual(sum, 3)
            expectation.fulfill() //
        }
        
        wait(for: [expectation], timeout: 0.05)
    }
}
