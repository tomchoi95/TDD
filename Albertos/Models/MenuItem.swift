//
//  MenuItem.swift
//  Albertos
//
//  Created by 최범수 on 2025-04-14.
//

import Foundation

struct MenuItem: Identifiable {
    let category: String
    let name: String

    var id: String { name }
}
