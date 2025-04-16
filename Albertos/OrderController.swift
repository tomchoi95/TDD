//
//  File.swift
//  Albertos
//
//  Created by 최범수 on 2025-04-17.
//

import Foundation
import Combine

public class OrderController: ObservableObject {
    @Published private(set) var order: Order
    
    init(order: Order = Order(items: [])) {
        self.order = order
    }
    
    func isItemInOrder(_ item: Item) -> Bool {
        order.items.contains(where: { $0.id == item.id })
    }
    
    func addToOrder(item: MenuItem) {
        order.items.append(item)
    }
    
    func removeFromOrder(item: MenuItem) {
        order.items.removeAll { $0.id == item.id }
    }
}
