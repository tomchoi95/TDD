//
//  Collection+Safe.swift
//  Albertos
//
//  Created by 최범수 on 2025-04-19.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Element? {
        return self.indices.contains(index) ? self[index] : nil
    }
}
