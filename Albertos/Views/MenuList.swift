//
//  ContentView.swift
//  Albertos
//
//  Created by 최범수 on 2025-04-19.
//

import SwiftUI
import Combine

extension MenuList {
    class ViewModel: ObservableObject {
        @Published private(set) var sections: [MenuSection]
        private var cancellables = Set<AnyCancellable>()
        
        init(menuFetching: MenuFetching, menuGrouping: @escaping ([MenuItem]) -> ([MenuSection]) = groupMenuByCategory) {
            self.sections = menuGrouping(menu)
            
            menuFetching.fetchMenu()
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { _ in }) { [weak self] items in
                    self?.sections = menuGrouping(items)
                }
                .store(in: &cancellables)
        }
    }
}

struct MenuList: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        //Initializer 'init(_:rowContent:)' requires that 'MenuSection' conform to 'Identifiable' -> 메뉴 섹션 Identifiable 만족하러 가자.
        List(viewModel.sections) { section in
            Section {
                ForEach(section.items) { MenuRow(viewModel: .init(item: $0)) }
            } header: {
                Text(section.category)
            }
        }
    }
}

#Preview {
    MenuList(viewModel: .init(menuFetching: MenuFetchingPlaceholder()))
}
