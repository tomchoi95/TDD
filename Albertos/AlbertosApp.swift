//
//  AlbertosApp.swift
//  Albertos
//
//  Created by 최범수 on 2025-04-14.
//

import SwiftUI

@main
struct AlbertosApp: App {
    @StateObject private var orderController = OrderController()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MenuList(viewModel: .init(menuFetching: MenuFetchingPlaceholder()))
                    .navigationTitle("Alberto's Italian Restaurant")
                    .environmentObject(orderController)
            }
        }
    }
}

extension [MenuItem] {
    static let mockItems: [MenuItem] = [
        MenuItem(category: "starters", name: "Caprese Salad", spicy: false, price: 9.99),
        MenuItem(category: "starters", name: "Arancini Balls", spicy: false, price: 8.49),
        MenuItem(category: "pastas", name: "Penne all'Arrabbiata", spicy: true, price: 11.99),
        MenuItem(category: "pastas", name: "Spaghetti Carbonara", spicy: false, price: 12.49),
        MenuItem(category: "drinks", name: "Water", spicy: false, price: 1.99),
        MenuItem(category: "drinks", name: "Red Wine", spicy: false, price: 4.99),
        MenuItem(category: "desserts", name: "Tiramisù", spicy: false, price: 5.99),
        MenuItem(category: "desserts", name: "Crema Catalana", spicy: false, price: 5.49),
    ]
}

func groupMenuByCategory(_ menu: [MenuItem]) -> [MenuSection] {
    return Dictionary(grouping: menu, by: { $0.category } )
        .map { MenuSection(category: $0.key, items: $0.value) }
        .sorted { $0.category > $1.category }
}

let menu = [
    MenuItem(category: "starters", name: "Caprese Salad", spicy: false, price: 9.99),
    MenuItem(category: "starters", name: "Arancini Balls", spicy: false, price: 8.49),
    MenuItem(category: "pastas", name: "Penne all'Arrabbiata", spicy: true, price: 11.99),
    MenuItem(category: "pastas", name: "Spaghetti Carbonara", spicy: false, price: 12.49),
    MenuItem(category: "drinks", name: "Water", spicy: false, price: 1.99),
    MenuItem(category: "drinks", name: "Red Wine", spicy: false, price: 4.99),
    MenuItem(category: "desserts", name: "Tiramisù", spicy: false, price: 5.99),
    MenuItem(category: "desserts", name: "Crema Catalana", spicy: false, price: 5.49)
]
