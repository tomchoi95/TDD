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
                ForEach(section.items) { item in
                    Text(item.name)
                }
            } header: {
                Text(section.category)
            }
        }
    }
}

#Preview {
    MenuList()
}
