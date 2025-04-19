//
//  MenuItemDetailViewModelTests.swift
//  AlbertosTests
//
//  Created by 최범수 on 2025-04-17.
//

import Foundation
import XCTest

@testable import Albertos

final class MenuItemDetailViewModelTests: XCTestCase {
    // 메뉴가 장바구니에 담겨있으면, 주문 버튼은 "주문 삭제"를 표시해야 합니다.
    func testWhenItemIsInOrderButtonSaysRemove() {
        // Arrange
        let item = MenuItem.fixture()
        let orderController = OrderController()
        let viewModel = MenuItemDetail.ViewModel(item: item, orderController: orderController)
        
        // Act
        orderController.addToOrder(item)
        
        // Assert
        XCTAssertEqual(viewModel.addOrRemoveFromOrderButtonText, "Remove from Order")
    }
    
    // 메뉴가 장바구니에 담겨있지 않으면, 주문 버튼은 "주문 추가"를 표시해야 합니다.
    func testWhenItemIsNotInOrderButtonSaysAdd() {
        // Arrange
        let item = MenuItem.fixture()
        let orderController = OrderController()
        let viewModel = MenuItemDetail.ViewModel(item: item, orderController: orderController)
        
        
        XCTAssertEqual(viewModel.addOrRemoveFromOrderButtonText, "Add to Order")
    }
}
