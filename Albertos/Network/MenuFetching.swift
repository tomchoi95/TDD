//
//  MenuFetching.swift
//  Albertos
//
//  Created by 최범수 on 2025-04-19.
//

import Foundation
import Combine

protocol MenuFetching {
    func fetchMenu() -> AnyPublisher<[MenuItem], Error>
}
