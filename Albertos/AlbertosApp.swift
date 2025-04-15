//
//  AlbertosApp.swift
//  Albertos
//
//  Created by 최범수 on 2025-04-14.
//

import SwiftUI

@main
struct AlbertosApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MenuList(viewModel: .init(menuFetching: MenuFetchingPlaceholder()))
                    .navigationTitle("Alberto's Italian Restaurant")
            }
        }
    }
}

extension [MenuItem] {
    static let mockItems: [MenuItem] = [
        MenuItem(name: "Caprese Salad", category: "starters", spicy: false, price: 9.99),
        MenuItem(name: "Arancini Balls", category: "starters", spicy: false, price: 8.49),
        MenuItem(name: "Penne all'Arrabbiata", category: "pastas", spicy: true, price: 11.99),
        MenuItem(name: "Spaghetti Carbonara", category: "pastas", spicy: false, price: 12.49),
        MenuItem(name: "Water", category: "drinks", spicy: false, price: 1.99),
        MenuItem(name: "Red Wine", category: "drinks", spicy: false, price: 4.99),
        MenuItem(name: "Tiramisù", category: "desserts", spicy: false, price: 5.99),
        MenuItem(name: "Crema Catalana", category: "desserts", spicy: false, price: 5.49),
    ]
}

func groupMenuByCategory(_ menu: [MenuItem]) -> [MenuSection] {
    return Dictionary(grouping: menu, by: { $0.category } )
        .map { MenuSection(category: $0.key, items: $0.value) }
        .sorted { $0.category > $1.category }
}

let menu = [
    MenuItem(name: "Caprese Salad", category: "starters", spicy: false, price: 9.99),
    MenuItem(name: "Arancini Balls", category: "starters", spicy: false, price: 8.49),
    MenuItem(name: "Penne all'Arrabbiata", category: "pastas", spicy: true, price: 11.99),
    MenuItem(name: "Spaghetti Carbonara", category: "pastas", spicy: false, price: 12.49),
    MenuItem(name: "Water", category: "drinks", spicy: false, price: 1.99),
    MenuItem(name: "Red Wine", category: "drinks", spicy: false, price: 4.99),
    MenuItem(name: "Tiramisù", category: "desserts", spicy: false, price: 5.99),
    MenuItem(name: "Crema Catalana", category: "desserts", spicy: false, price: 5.49)
]
