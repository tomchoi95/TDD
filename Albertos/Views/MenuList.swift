//
//  ContentView.swift
//  Albertos
//
//  Created by 최범수 on 2025-04-19.
//

import SwiftUI

extension MenuList {
    class ViewModel: ObservableObject {
        @Published var sections: [MenuSection]
        
        init(menu: [MenuItem], menuGrouping: @escaping ([MenuItem]) -> ([MenuSection]) = groupMenuByCategory ) {
            self.sections = menuGrouping(menu)
        }
    }
}

struct MenuList: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        //Initializer 'init(_:rowContent:)' requires that 'MenuSection' conform to 'Identifiable' -> 메뉴 섹션 Identifiable 만족하러 가자.
        List(viewModel.sections) { section in
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
    MenuList(viewModel: .init(menu: menu))
}
