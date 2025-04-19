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
    
    var id: String { name }
}
