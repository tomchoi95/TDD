//
//  MenuItem.swift
//  Albertos
//
//  Created by 최범수 on 2025-04-14.
//

import Foundation

/*
struct MenuItem: Identifiable {
    let category: String
    let name: String

    var id: String { name }
}
 */

/* 아래와 같은 모델로 변경을 할 것임. */
/*
 struct MenuItem {
 let name: String
 let category: String
 let spicy: Bool
 }
*/

// 다시 아래와 같이 모델 수정.
struct MenuItem: Equatable, Identifiable {
    let name: String
    let category: String
    let spicy: Bool
    let price: Double
    var id: String { name }
}

extension MenuItem {
    static func fixture(category: String = "category", name: String = "name", spicy: Bool = false, price: Double = 0.0) -> MenuItem {
        MenuItem(name: name, category: category, spicy: spicy, price: price)
    }
}
