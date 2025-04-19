//
//  MenuSection.swift
//  Albertos
//
//  Created by 최범수 on 2025-04-19.
//

import Foundation

struct MenuSection {
    let items: [MenuItem]
    let category: String
    
    var id: String { category }
}
