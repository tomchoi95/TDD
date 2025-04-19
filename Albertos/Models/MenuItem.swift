//
//  MenuItem.swift
//  Albertos
//
//  Created by 최범수 on 2025-04-19.
//

import Foundation

// Define Menu Item
// It shuld have id, categoty, name

struct MenuItem: Identifiable {
    let category: String
    let name: String
    let spicy: Bool
    let price: Double
    
    var id: String { name }
}

extension MenuItem {
    static func fixture(category: String = "category", name: String = "name", spicy: Bool = false, price: Double = 0) -> MenuItem {
        
        return MenuItem(category: category, name: name, spicy: spicy, price: price)
    }
}
