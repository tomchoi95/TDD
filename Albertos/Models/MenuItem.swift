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
struct MenuItem {
    let name: String
    let category: String
    let spicy: Bool
}
 
