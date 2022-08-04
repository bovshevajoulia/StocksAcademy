//
//  SearchResponse.swift
//  StocksAcademy
//
//  Created by bovsheva on 19.06.2022.
//

import Foundation

/// API response for search
struct SearchResponse: Codable {
    let count: Int
    let result: [SearchResult]
    
    init() {
        self.count = 0
        self.result = []
    }
}

/// A single search result
struct SearchResult: Codable {
    let description: String
    let displaySymbol: String
    let symbol: String
    let type:  String
}

struct SymbolData: Codable {
    let description: String
    let symbol: String
}
