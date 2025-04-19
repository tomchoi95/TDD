//
//  Collection+Safe.swift
//  Albertos
//
//  Created by 최범수 on 2025-04-14.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        print("indices: \(self.indices), type: \(type(of: self.indices))")
        return indices.contains(index) ? self[index] : nil
    }
}
