//
//  ContentView.swift
//  Albertos
//
//  Created by 최범수 on 2025-04-14.
//

import SwiftUI
import Combine

struct MenuList: View {
    @StateObject var viewModel: MenuListViewModel
    
    init(viewModel: MenuListViewModel = MenuListViewModel(menuFetching: MenuFetchingPlaceholder())) {
        _viewModel = @StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        switch viewModel.sections {
            case .success(let sections):
                List(sections) { section in
                    Section {
                        ForEach(section.items) { item in
                            MenuRow(item: item)
                        }
                    } header: {
                        Text(section.category)
                    }
                }
            case .failure(let error):
                VStack {
                    Text("An error occoured:")
                    Text(error.localizedDescription)
                        .italic()
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


class MenuListViewModel: ObservableObject {
    @Published private(set) var sections: Result<[MenuSection], Error> = .success([])
    
    private var cancellables = Set<AnyCancellable>()
    
    init(
        menuFetching: MenuFetching,
        menuGrouping: @escaping ([MenuItem]) -> [MenuSection] = groupMenuByCategory
    ) {
        menuFetching.fetchMenu()
            .map(menuGrouping)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.sections = .failure(error)
                }
            } receiveValue: { [weak self] menuSection in
                self?.sections = .success(menuSection)
            }
            .store(in: &cancellables)

    }
}


#Preview {
    MenuList(viewModel: .init(menuFetching: MenuFetchingPlaceholder()))
}
