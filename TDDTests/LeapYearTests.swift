//
//  LeapYearTests.swift
//  TDDTests
//
//  Created by 최범수 on 2025-04-14.
//

import XCTest

class LeapYear {
    func isLeap(_ year: Int) -> Bool {
        return true
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
}
