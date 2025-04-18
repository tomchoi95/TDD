//
//  Order.swift
//  Albertos
//
//  Created by 최범수 on 2025-04-17.
//

import Foundation

struct Order {
    var items: [MenuItem]
    var total: Double {
        items.reduce(0) { $0 + $1.price }
    }
}
