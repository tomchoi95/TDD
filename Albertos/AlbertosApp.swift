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
            MenuList()
        }
    }
}

let menu = [
    MenuItem(category: "starters", name: "Caprese Salad"),
    MenuItem(category: "starters", name: "Arancini Balls"),
    MenuItem(category: "pastas", name: "Penne all'Arrabbiata"),
    MenuItem(category: "pastas", name: "Spaghetti Carbonara"),
    MenuItem(category: "drinks", name: "Water"),
    MenuItem(category: "drinks", name: "Red Wine"),
    MenuItem(category: "desserts", name: "Tiramisù"),
    MenuItem(category: "desserts", name: "Crema Catalana"),
]
