import SwiftUI
import Combine

class OrderController: ObservableObject {
    @Published private(set) var order: Order
    
    init(order: Order = Order(items: [])) {
        self.order = order
    }
    
    func addToOrder(_ item: MenuItem) {
        order.items.append(item)
    }
    
    func removeFromOrder(_ item: MenuItem) {
        order.items.removeAll { $0.id == item.id }
    }
    
    func isItemInOrder(_ item: MenuItem) -> Bool {
        order.items.contains { $0.id == item.id }
    }
} 
