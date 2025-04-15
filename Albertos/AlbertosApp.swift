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
                MenuList(sections: groupMenuByCategory(.mockItems))
                    .navigationTitle("Alberto's")
            }
        }
    }
}

extension [MenuItem] {
    static let mockItems: [MenuItem] = [
        MenuItem.fixture(category: "starters", name: "Caprese Salad"),
        MenuItem.fixture(category: "starters", name: "Arancini Balls"),
        MenuItem.fixture(category: "pastas", name: "Penne all'Arrabbiata"),
        MenuItem.fixture(category: "pastas", name: "Spaghetti Carbonara"),
        MenuItem.fixture(category: "drinks", name: "Water"),
        MenuItem.fixture(category: "drinks", name: "Red Wine"),
        MenuItem.fixture(category: "desserts", name: "Tiramisù"),
        MenuItem.fixture(category: "desserts", name: "Crema Catalana"),
    ]
}

func groupMenuByCategory(_ menu: [MenuItem]) -> [MenuSection] {
    return Dictionary(grouping: menu, by: { $0.category } )
        .map { MenuSection(category: $0.key, items: $0.value) }
        .sorted { $0.category > $1.category }
}

extension MenuItem {
    static func fixture(category: String = "category", name: String = "name", spicy: Bool = false) -> MenuItem {
        MenuItem(name: name, category: category, spicy: spicy)
    }
}
