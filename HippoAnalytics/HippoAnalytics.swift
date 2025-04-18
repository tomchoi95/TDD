//
//  HippoAnalytics.swift
//  HippoAnalytics
//
//  Created by 최범수 on 2025-04-18.
//

import Foundation

public class HippoAnalytics {
    public static let shared = HippoAnalytics()
    private init() {}
    
    var apiKey: String?
    
    public func configure(apiKey: String) {
        self.apiKey = apiKey
    }
    
    public func logEvent(named name: String, properties: [String: Any]? = .none) {
        guard let apiKey = apiKey else { debugPrint("🦛 HippoAnalytics: API key is not set."); return }
        debugPrint("apiKey: \(apiKey)")
        
        if let properties = properties {
            debugPrint("🦛 HippoAnalytics: Logged event named '\(name)' with properties '\(properties)'")
        } else {
            debugPrint("🦛 HippoAnalytics: Logged event named '\(name)")
        }
        
    }
}
