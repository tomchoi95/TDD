//
//  FizzBuzz.swift
//  TDD
//
//  Created by 최범수 on 2025-04-14.
//

import Foundation

func fizzBuzz(_ n: Int) -> String {
    switch (n % 3 == 0, n % 5 == 0) {
        case (false, false): "\(n)"
        case (true, false): "Fizz"
        case (false, true): "Buzz"
        case (true, true): "FizzBuzz"
    }
}

func asyncSum(a: Int, b: Int) async -> Int {
    try? await Task.sleep(for: .seconds(1))
    
    return a + b
}
