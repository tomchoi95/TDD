//
//  MenuRow.swift
//  Albertos
//
//  Created by 최범수 on 2025-04-19.
//

import SwiftUI

extension MenuRow {
    class ViewModel: ObservableObject {
        @Published private(set) var item: MenuItem
        @Published private(set) var itemName: String
        
        init(item: MenuItem) {
            self.item = item
            self.itemName = item.spicy ? item.name + " 🌶️" : item.name
        }
    }
}

struct MenuRow: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        HStack {
            Text(viewModel.itemName)
            Spacer()
            Text("$\(viewModel.item.price, specifier: "%.2f")")
        }
    }
}

#Preview {
    MenuRow(viewModel: .init(item: .fixture(category: "category", name: "name", spicy: true, price: 21.99)))
}
