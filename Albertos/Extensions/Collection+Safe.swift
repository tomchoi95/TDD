//
//  Collection+Safe.swift
//  Albertos
//
//  Created by 최범수 on 2025-04-14.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
