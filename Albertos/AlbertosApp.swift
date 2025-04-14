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
        MenuItem(category: "starters", name: "Caprese Salad"),
        MenuItem(category: "starters", name: "Arancini Balls"),
        MenuItem(category: "pastas", name: "Penne all'Arrabbiata"),
        MenuItem(category: "pastas", name: "Spaghetti Carbonara"),
        MenuItem(category: "drinks", name: "Water"),
        MenuItem(category: "drinks", name: "Red Wine"),
        MenuItem(category: "desserts", name: "Tiramisù"),
        MenuItem(category: "desserts", name: "Crema Catalana"),
    ]
}

func groupMenuByCategory(_ menu: [MenuItem]) -> [MenuSection] {
    return Dictionary(grouping: menu, by: { $0.category } )
        .map { MenuSection(category: $0.key, items: $0.value) }
        .sorted { $0.category > $1.category }
}
