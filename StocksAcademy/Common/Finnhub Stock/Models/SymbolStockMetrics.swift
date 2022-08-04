//
//  SymbolStockMetrics.swift
//  StocksAcademy
//
//  Created by bovsheva on 26.06.2022.
//

import Foundation

struct SymbolStockMetrics {
    
    let symbol: String
    var metrics: Metrics
    
    init(symbol: String = "",
         metrics: Metrics = Metrics(tenDayAverageTradingVolume: 0,
                                    annualWeekHigh: 0,
                                    annualWeekLow: 0,
                                    annualWeekLowDate: "",
                                    annualWeekPriceReturnDaily: 0,
                                    beta: 0)
    ) {
        self.symbol = symbol
        self.metrics = metrics
    }
}

extension SymbolStockMetrics {
    static let dummySymbolStockMetrics = Metrics(tenDayAverageTradingVolume: 0,
                                                 annualWeekHigh: 0,
                                                 annualWeekLow: 0,
                                                 annualWeekLowDate: "",
                                                 annualWeekPriceReturnDaily: 0,
                                                 beta: 0)
}
