//
//  MenuRow.swift
//  Albertos
//
//  Created by 최범수 on 2025-04-19.
//

import SwiftUI

extension MenuRow {
    class ViewModel: ObservableObject {
        @Published var text: String
        
        init(item: MenuItem) {
            self.text = item.spicy ? "\(item.name) 🌶️" : item.name
        }
    }
}

struct MenuRow: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        Text(viewModel.text)
    }
}

#Preview {
    MenuRow(viewModel: .init(item: .fixture()))
}
