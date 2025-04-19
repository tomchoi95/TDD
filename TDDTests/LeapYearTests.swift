//
//  LeapYearTests.swift
//  TDDTests
//
//  Created by 최범수 on 2025-04-14.
//

import XCTest

class LeapYear {
    func isLeap(_ year: Int) -> Bool {
        guard !(year % 400 == 0) else { return true }
        guard !(year % 100 == 0) else { return false }
        return year % 4 == 0
    }
}

class LeapYearTests: XCTestCase {
    
    var leapYear: LeapYear!
    
    override func setUp() {
        super.setUp()
        leapYear = LeapYear()
    }
    
    override func tearDown() {
        leapYear = nil
        super.tearDown()
    }
    
    func testEvenlyDivisibleByFourIsLeap() {
        XCTAssertTrue(leapYear.isLeap(2020))
    }
    
    func testNotEvenlyDivisibleByFourIsLeap() {
        XCTAssertFalse(leapYear.isLeap(2019))
    }
    
    func testEvenlyDivisibleBy100IsNotLeap() {
        XCTAssertFalse(leapYear.isLeap(2100))
    }
    
    func testEvenlyDivisibleBy400IsLeap() {
        XCTAssertTrue(leapYear.isLeap(2000))
    }
}
