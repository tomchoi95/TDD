//
//  ContentView.swift
//  Albertos
//
//  Created by 최범수 on 2025-04-19.
//

import SwiftUI

struct MenuList: View {
    let sections: [MenuSection]
    
    var body: some View {
        //Initializer 'init(_:rowContent:)' requires that 'MenuSection' conform to 'Identifiable' -> 메뉴 섹션 Identifiable 만족하러 가자.
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
    MenuList(sections: groupMenuByCategory(menu))
}
