//
//  MenuSection.swift
//  Albertos
//
//  Created by 최범수 on 2025-04-14.
//

import Foundation

struct MenuSection: Identifiable {
    let category: String
    let items: [MenuItem]
    
    var id: String { category }
}
