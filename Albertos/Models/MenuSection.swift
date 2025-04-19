//
//  MenuSection.swift
//  Albertos
//
//  Created by 최범수 on 2025-04-19.
//

import Foundation

struct MenuSection: Identifiable {
    let items: [MenuItem]
    let category: String
    
    var id: String { category }
}

extension MenuSection {
    func fixture(items: [MenuItem] = [.fixture()], categoty: String = "category") -> MenuSection {
        
        return MenuSection(items: items, category: categoty)
    }
}
