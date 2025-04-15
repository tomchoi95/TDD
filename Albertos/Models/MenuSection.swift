//
//  MenuSection.swift
//  Albertos
//
//  Created by 최범수 on 2025-04-14.
//

import Foundation

struct MenuSection: Identifiable, Equatable {
    let category: String
    let items: [MenuItem]
    
    var id: String { category }
}

extension MenuSection {
    static func fixture(category: String = "Test") -> MenuSection {
        MenuSection(category: category, items: [MenuItem.fixture()])
    }
}
