//
//  XCTUnwrapTest.swift
//  TDDTests
//
//  Created by 최범수 on 2025-04-14.
//

import XCTest

fileprivate struct User {
    let id: UUID
    let name: String
    let email: String
}

fileprivate class UserRepository {
    var users: [User] = [
        User(id: UUID(), name: "a", email: "a@a"),
        User(id: UUID(), name: "b", email: "b@b"),
    ]
    
    func getUserBy(id: UUID) -> User? {
        users.first { $0.id == id }
    }
    
    func getUserBy(name: String) -> User? {
        users.first { $0.name == name }
    }
}

class XCTUnwrapTest: XCTestCase {
    
    fileprivate var userRepository: UserRepository!
    
    override func setUp() {
        super.setUp()
        userRepository = UserRepository()
    }
    
    override func tearDown() {
        userRepository = nil
        super.tearDown()
    }
    
    func testUnwrap() throws {
        let user: User = try XCTUnwrap(userRepository.getUserBy(name: "a"))
        
        XCTAssertEqual(user.name, "a")
        XCTAssertEqual(user.email, "a@a")
    }
}
