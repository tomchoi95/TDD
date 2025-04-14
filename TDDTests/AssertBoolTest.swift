//
//  AssertBool.swift
//  TDDTests
//
//  Created by 최범수 on 2025-04-14.
//

import XCTest
@testable import TDD

final class AssertBoolTest: XCTestCase {
    
    // 테스트 대상 클래스의 인스턴스 변수를 선언.
    var assertBool: AssertBool!
    
    // 테스트 대상 객체 초기화.
    override func setUp() {
        super.setUp()
        assertBool = AssertBool()
    }
    
    // 테스트 실행 후 메모리 정리.
    override func tearDown() {
        assertBool = nil
        super.tearDown()
    }
    
    func testIsGreaterThanFive() {
        // give
        let input = 2
        
        // when
        let result = assertBool.isGreaterThanFive(input)
        
        // then
        XCTAssertFalse(result, "2는 5보다 작습니다.")
    }
    
    func testIsGreaterThanFive2() {
        let input = 6
        
        let result = assertBool.isGreaterThanFive(input)
        
        XCTAssertTrue(result, "6은 5보다 큽니다.")
    }
    
    func testTsLessThanTen() {
        let input: Int = 1
        
        let result = assertBool.isLessThanTen(input)
        
        XCTAssertTrue(result, "1은 10보다 작습니다.")
    }
    
}
