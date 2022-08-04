//
//  StockSymbolItem.swift
//  StocksAcademy
//
//  Created by bovsheva on 26.07.2022.
//

import Foundation
import SwiftUI

extension StocksAcademy {
    
    struct StockSymbolItem: Identifiable {
        let id = UUID()
        let symbol: String
        let name: String
        
        
        let currentPrice: Double
        let percentChange: Double
        let highPrice: Double
        let lowPrice: Double
        let openPrice: Double
        let previousClosePrice: Double
        
        let color: Color
        let chart: String
        let image: Image
    }
    
    /// Dummy data for UI
    static let dummyStockSymbol = StockSymbolItem(symbol: "BTC",
                                                  name: "Bitcoin USD",
                                                  currentPrice: 21088.1,
                                                  percentChange: -4.31,
                                                  highPrice: 21315.16,
                                                  lowPrice: 21019.68,
                                                  openPrice: 21315.73,
                                                  previousClosePrice: 21019.68,
                                                  color: Color.red,
                                                  chart: "red-chart",
                                                  image: Image("bitcoin"))

    static func dummyStockSymbols() -> [String: StocksAcademy.StockSymbolItem] {
        var data: [String: StocksAcademy.StockSymbolItem] = [:]
        
        data["BTC"] = StockSymbolItem(symbol: "BTC",
                                      name: "Bitcoin USD",
                                      currentPrice: 21088.1,
                                      percentChange: -4.31,
                                      highPrice: 21315.160,
                                      lowPrice: 21019.680,
                                      openPrice: 21315.730,
                                      previousClosePrice: 21019.680,
                                      color: Color.red,
                                      chart: "red-chart",
                                      image: Image("bitcoin"))
        
        data["ETH"] = StockSymbolItem(symbol: "ETH",
                                      name: "Ethereum USD",
                                      currentPrice: 1415.1,
                                      percentChange: -0.92,
                                      highPrice: 1444.160,
                                      lowPrice: 1409.680,
                                      openPrice: 1442.730,
                                      previousClosePrice: 1409.68,
                                      color: Color.red,
                                      chart: "red-chart",
                                      image: Image("ethereum"))
        
        data["SOUN"] = StockSymbolItem(symbol: "SOUN",
                                       name: "SoundHound AI, Inc.",
                                       currentPrice: 4.1,
                                       percentChange: 9.92,
                                       highPrice: 4.160,
                                       lowPrice: 3.580,
                                       openPrice: 3.730,
                                       previousClosePrice: 3.28,
                                       color: Color.green,
                                       chart: "green-chart",
                                       image: Image(systemName: "dollarsign.circle.fill"))
        
        data["AAPL"] = StockSymbolItem(symbol: "AAPL",
                                       name: "Apple Inc.",
                                       currentPrice: 152.95,
                                       percentChange: -0.74,
                                       highPrice: 155.04,
                                       lowPrice: 152.28,
                                       openPrice: 154.01,
                                       previousClosePrice: 152.28,
                                       color: Color.red,
                                       chart: "red-chart",
                                       image: Image(systemName: "dollarsign.circle.fill"))
        
        return data
    }
}
