//
//  MenuItemDetail.swift
//  Albertos
//
//  Created by 최범수 on 2025-04-17.
//

import SwiftUI

struct MenuItemDetail: View {
    @ObservedObject private(set) var viewModel: ViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.item.name)
                .font(.title)
            
            Text(viewModel.item.description)
                .padding()
            
            Text("Price: $\(viewModel.item.price, specifier: "%.2f")")
                .font(.headline)
            
            Button(viewModel.addOrRemoveFromOrderButtonText) {
                viewModel.addOrRemoveFromOrder()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}

extension MenuItemDetail {
    class ViewModel: ObservableObject {
        let item: MenuItem
        let orderController: OrderController
        
        init(item: MenuItem, orderController: OrderController) {
            self.item = item
            self.orderController = orderController
        }
        
        var addOrRemoveFromOrderButtonText: String {
            orderController.isItemInOrder(item) ? "Remove from Order" : "Add to Order"
        }
        
        func addOrRemoveFromOrder() {
            if orderController.isItemInOrder(item) {
                orderController.removeFromOrder(item)
            } else {
                orderController.addToOrder(item)
            }
        }
    }
}


