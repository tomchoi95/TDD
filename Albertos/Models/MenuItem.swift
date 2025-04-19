//
//  MenuItem.swift
//  Albertos
//
//  Created by 최범수 on 2025-04-14.
//

import Foundation

/*
struct MenuItem: Identifiable {
    let category: String
    let name: String

    var id: String { name }
}
 */

/* 아래와 같은 모델로 변경을 할 것임. */
/*
 struct MenuItem {
 let name: String
 let category: String
 let spicy: Bool
 }
*/

// 다시 아래와 같이 모델 수정.
struct MenuItem {
    let name: String
    let spicy: Bool
    let price: Double
    let description: String
    var id: String { name }
    private let categoryObject: Category
    var category: String { categoryObject.name }
    
    enum CodingKeys: String, CodingKey {
        case name, spicy, price, description
        case categoryObject = "category"
    }
    
    struct Category: Codable, Equatable {
        let name: String
    }
}

extension MenuItem: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.spicy = try container.decode(Bool.self, forKey: .spicy)
        self.price = try container.decode(Double.self, forKey: .price)
        self.description = try container.decode(String.self, forKey: .description)
        self.categoryObject = try container.decode(Category.self, forKey: .categoryObject)
    }
}

extension MenuItem {
    init(category: String, name: String, spicy: Bool, price: Double, description: String = "") {
        self.categoryObject = .init(name: category)
        self.name = name
        self.spicy = spicy
        self.price = price
        self.description = description
    }
}

extension MenuItem: Equatable, Identifiable {}

extension MenuItem {
    static func fixture(
        category: String = "category", 
        name: String = "name", 
        spicy: Bool = false, 
        price: Double = 0.0,
        description: String = ""
    ) -> MenuItem {
        MenuItem(category: category, name: name, spicy: spicy, price: price, description: description)
    }
}
