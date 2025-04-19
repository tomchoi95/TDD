//
//  AlbertosApp.swift
//  Albertos
//
//  Created by 최범수 on 2025-04-19.
//

import SwiftUI

@main
struct AlbertosApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MenuList(sections: groupMenuByCategory(menu))
                    .navigationTitle("Alberto's")
            }
        }
    }
}

let menu = [
    MenuItem.fixture(category: "starters", name: "Caprese Salad"),
    MenuItem.fixture(category: "starters", name: "Arancini Balls"),
    MenuItem.fixture(category: "pastas", name: "Penne all'Arrabbiata"),
    MenuItem.fixture(category: "pastas", name: "Spaghetti Carbonara"),
    MenuItem.fixture(category: "drinks", name: "Water"),
    MenuItem.fixture(category: "drinks", name: "Red Wine"),
    MenuItem.fixture(category: "desserts", name: "Tiramisù"),
    MenuItem.fixture(category: "desserts", name: "Crema Catalana"),
]
