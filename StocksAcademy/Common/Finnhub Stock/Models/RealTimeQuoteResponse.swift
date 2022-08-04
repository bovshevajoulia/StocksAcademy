//
//  RealTimeQuoteResponse.swift
//  StocksAcademy
//
//  Created by bovsheva on 26.06.2022.
//

import Foundation


struct RealTimeQuote: Codable {
    let currentPrice: Double
    let change: Double
    let percentChange: Double
    let highPrice: Double
    let lowPrice: Double
    let openPrice: Double
    let previousClosePrice: Double
    
    
    enum CodingKeys: String, CodingKey {
        case currentPrice = "c"
        case change = "d"
        case percentChange = "dp"
        case highPrice = "h"
        case lowPrice = "l"
        case openPrice = "o"
        case previousClosePrice = "pc"
    }
    
    init (currentPrice: Double = 0,
          change: Double = 0,
          percentChange: Double = 0,
          highPrice: Double = 0,
          lowPrice: Double = 0,
          openPrice: Double = 0,
          previousClosePrice: Double = 0) {
        
        self.currentPrice = currentPrice
        self.change = change
        self.percentChange = percentChange
        self.highPrice = highPrice
        self.lowPrice = lowPrice
        self.openPrice = openPrice
        self.previousClosePrice = previousClosePrice
    }
}
