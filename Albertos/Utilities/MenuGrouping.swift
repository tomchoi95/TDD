//
//  MenuGrouping.swift
//  Albertos
//
//  Created by 최범수 on 2025-04-19.
//

import Foundation

func groupMenuByCategory(_ menu: [MenuItem]) -> [MenuSection] {
    let groupedMenu = Dictionary(grouping: menu) { $0.category } // 카테고리 기준으로 그루핑.
        .map { (key: String, value: [MenuItem]) in
            return MenuSection(items: value, category: key)
        }
        .sorted { $0.category > $1.category }
    
    return groupedMenu
}
