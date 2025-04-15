//
//  ContentView.swift
//  Albertos
//
//  Created by 최범수 on 2025-04-14.
//

import SwiftUI
import Combine

struct MenuList: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        List(viewModel.sections, id: \.category) { section in
            Section {
                ForEach(section.items, id: \.name) { item in
                    MenuRow(item: item)
                }
            } header: {
                Text(section.category)
            }
        }
    }
}

struct MenuRow: View {
    let item: MenuItem

    var body: some View {
        HStack {
            Text(item.spicy ? "🌶️ \(item.name)" : item.name)
            Spacer()
            Text("$\(item.price, specifier: "%.2f")")
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
