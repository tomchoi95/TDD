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
        @Published private(set) var sections: Result<[MenuSection], Error> = .success([])
        private let menuFetching: MenuFetching
        private let menuGrouping: ([MenuItem]) -> ([MenuSection])
        
        init(menuFetching: MenuFetching, menuGrouping: @escaping ([MenuItem]) -> ([MenuSection]) = groupMenuByCategory) {
            self.menuFetching = menuFetching
            self.menuGrouping = menuGrouping
            fetchMenu()
        }
        
        func fetchMenu() {
            menuFetching.fetchMenu()
                .receive(on: RunLoop.main)
                .map(menuGrouping)
                .map { Result<[MenuSection], Error>.success($0) }
                .catch { Just(Result<[MenuSection], Error>.failure($0)) }
                .assign(to: &$sections)
        }
        
        func retry() {
            fetchMenu()
        }
    }
}

struct MenuList: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        switch viewModel.sections {
            case .success(let sections):
                List(sections) { section in
                    Section {
                        ForEach(section.items) { MenuRow(viewModel: .init(item: $0)) }
                    } header: {
                        Text(section.category)
                    }
                }
            case .failure(let error):
                VStack {
                    Text("An error occurred while fetching menu data.")
                    Text(error.localizedDescription)
                        .italic()
                    Button("retry", action: viewModel.retry)
                        .padding()
                        .background(Color.blue)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
        }
        
    }
}

#Preview {
    MenuList(viewModel: .init(menuFetching: MenuFetchingPlaceholder()))
}
