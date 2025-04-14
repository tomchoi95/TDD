//
//  AssertBool.swift
//  TDDTests
//
//  Created by 최범수 on 2025-04-14.
//

import XCTest
@testable import TDD

final class AssertBool: XCTestCase {
    
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
    
}
