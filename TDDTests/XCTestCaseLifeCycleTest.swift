//
//  XCTestCaseLifeCycleTest.swift
//  TDDTests
//
//  Created by 최범수 on 2025-04-14.
//

import XCTest

class XCTestCaseLifeCycleTest: XCTestCase {
    
    override func setUpWithError() throws {
        print(#function + " Called")
    }
    
    override func setUp() {
        print(#function + " Called")
    }
    
    override func tearDown() {
        print(#function + " Called")
    }
    
    override func tearDownWithError() throws {
        print(#function + " Called")
    }
    
    func testMyFunction() {
        print(#function + " Called")
    }
}

        
