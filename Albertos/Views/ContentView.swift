//
//  ContentView.swift
//  Albertos
//
//  Created by 최범수 on 2025-04-14.
//

import SwiftUI

struct MenuList: View {
    let sections: [MenuSection]
    
    var body: some View {
        List(sections) { section in
            Section {
                ForEach(section.items, id: \.name) { item in
                    Text(item.name)
                }
            } header: {
                Text(section.category)
            }
        }
    }
}

struct MenuRow: View {
    let viewModel: ViewModel

    var body: some View {
        Text(viewModel.text)
    }
}

#Preview {
    MenuList(sections: groupMenuByCategory(.mockItems))
}
