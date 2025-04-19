//
//  MenuListView.swift
//  Albertos
//
//  Created by 최범수 on 2025-04-14.
//

import SwiftUI
import Combine

struct MenuList: View {
    @ObservedObject var viewModel: MenuListViewModel
    @EnvironmentObject var orderController: OrderController
    
    var body: some View {
        Group {
            switch viewModel.sections {
            case .success(let sections):
                List {
                    ForEach(sections) { section in
                        Section(header: Text(section.category)) {
                            ForEach(section.items) { item in
                                NavigationLink(destination: destination(for: item)) {
                                    MenuRow(item: item)
                                }
                            }
                        }
                    }
                }
            case .failure(let error):
                VStack {
                    Text("메뉴를 불러오는데 실패했습니다")
                        .font(.headline)
                    Text(error.localizedDescription)
                        .font(.subheadline)
                        .foregroundColor(.red)
                    Button("다시 시도") {
                        viewModel.retry()
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
        }
        .onAppear {
            viewModel.loadMenu()
        }
    }
    
    private func destination(for item: MenuItem) -> some View {
        MenuItemDetail(viewModel: .init(item: item, orderController: orderController))
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
    private let menuFetching: MenuFetching
    private let menuGrouping: ([MenuItem]) -> [MenuSection]
    
    init(
        menuFetching: MenuFetching,
        menuGrouping: @escaping ([MenuItem]) -> [MenuSection] = groupMenuByCategory
    ) {
        self.menuFetching = menuFetching
        self.menuGrouping = menuGrouping
        fetchMenu()
    }
    
    func fetchMenu() {
        menuFetching.fetchMenu()
            .map(menuGrouping)
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.sections = .failure(error)
                }
            } receiveValue: { [weak self] menuSection in
                self?.sections = .success(menuSection)
            }
            .store(in: &cancellables)
    }
    
    func retry() {
        fetchMenu()
    }
    
    func loadMenu() {
        fetchMenu()
    }
}

#Preview {
    MenuList(viewModel: .init(menuFetching: MenuFetchingPlaceholder()))
}
