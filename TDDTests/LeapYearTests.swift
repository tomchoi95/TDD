//
//  LeapYearTests.swift
//  TDDTests
//
//  Created by 최범수 on 2025-04-14.
//

import XCTest

class LeapYearTests: XCTestCase {
    func testEvenlyDivisibleByFourIsLeap() {
        XCTAssertTrue(isLeap(2020))
    }
}
