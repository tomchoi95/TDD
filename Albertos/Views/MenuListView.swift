//
//  ContentView.swift
//  Albertos
//
//  Created by 최범수 on 2025-04-14.
//

import SwiftUI
import Combine

struct MenuList: View {
    let viewModel: ViewModel
    
    var body: some View {
        List(viewModel.sections, id: \.category) { section in
            Section {
                ForEach(section.items, id: \.name) { item in
                    MenuRow(viewModel: .init(item: item))
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

extension MenuRow {
    struct ViewModel {
        let text: String
        
        init(item: MenuItem) {
            text = item.spicy ? "🌶️ \(item.name)" : item.name
        }
    }
}

extension MenuList {
    class ViewModel: ObservableObject {
        @Published private(set) var sections: [MenuSection] = []
        private var cancellables = Set<AnyCancellable>()
        
        init(
            menuFetching: MenuFetching,
            menuGrouping: @escaping ([MenuItem]) -> [MenuSection] = groupMenuByCategory
        ) {
            menuFetching.fetchMenu()
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { _ in }) { [weak self] items in
                    self?.sections = menuGrouping(items)
                }
                .store(in: &cancellables)
        }
    }
}

#Preview {
    MenuList(viewModel: .init(menuFetching: MenuFetchingPlaceholder()))
}
