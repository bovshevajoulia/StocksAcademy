//
//  SymbolStockCandles.swift
//  StocksAcademy
//
//  Created by bovsheva on 23.06.2022.
//

import Foundation

struct SymbolStockCandles {
    let symbol: String
    let candles: [CandleStick]
    
    init(symbol: String = "",
         candles: [CandleStick] = []
    ) {
        self.symbol = symbol
        self.candles = candles
    }
}

extension SymbolStockCandles {
    
    func getChangePercentage() -> Double {
        
        guard let latestDate = self.candles.first?.date else { return 0}
        
        let priorDate = latestDate.addingTimeInterval(-(3600 * 24))
        
        guard let latestClose = self.candles.first?.close,
                let priorClose = self.candles.first(
                where: {
                    Calendar.current.isDate($0.date, inSameDayAs: priorDate)
                })?.close
        else {
            return 0
        }
        // ((a-b)/a) * 100
        let diff = ((latestClose - priorClose)/priorClose) * 100
        return diff
    }
}

extension SymbolStockCandles {
    
    static public func dummySymbolStockCandles() -> SymbolStockCandles {
        return SymbolStockCandles(symbol: "AAPL",
                                  candles: SymbolStockCandles.dummyCandles()
        )
    }
    
    static public func dummyCandles() -> [CandleStick] {
        let candles = [ // "2016-04-14T10:44:00+0000"
            CandleStick(date: Date(), high: 3.32, low: 3.32, open: 3.32, close: 3.32),
            CandleStick(date: Date(), high: 3.32, low: 3.32, open: 3.32, close: 3.32),
            CandleStick(date: Date(), high: 3.32, low: 3.32, open: 3.32, close: 3.32),
            CandleStick(date: Date(), high: 3.32, low: 3.32, open: 3.32, close: 3.32),
            CandleStick(date: Date(), high: 3.32, low: 3.32, open: 3.32, close: 3.32),
            CandleStick(date: Date(), high: 3.32, low: 3.32, open: 3.32, close: 3.32),
            CandleStick(date: Date(), high: 3.32, low: 3.32, open: 3.32, close: 3.32),
            CandleStick(date: Date(), high: 3.32, low: 3.32, open: 3.32, close: 3.32),
            CandleStick(date: Date(), high: 3.32, low: 3.32, open: 3.32, close: 3.32),
            CandleStick(date: Date(), high: 3.32, low: 3.27, open: 3.27, close: 3.32),
            CandleStick(date: Date(), high: 3.28, low: 3.28, open: 3.28, close: 3.28),
            CandleStick(date: Date(), high: 3.2, low: 3.2, open: 3.2, close: 3.2),
            CandleStick(date: Date(), high: 3.19, low: 3.18, open: 3.185, close: 3.18),
            CandleStick(date: Date(), high: 3.19, low: 3.17, open: 3.175, close: 3.19),
            CandleStick(date: Date(), high: 3.17, low: 3.17, open: 3.17, close: 3.17),
            CandleStick(date: Date(), high: 3.18, low: 3.17, open: 3.175, close: 3.18),
            CandleStick(date: Date(), high: 3.18, low: 3.175, open: 3.175, close: 3.18),
            CandleStick(date: Date(), high: 3.19, low: 3.175, open: 3.18, close: 3.19),
            CandleStick(date: Date(), high: 3.19, low: 3.19, open: 3.19, close: 3.19)
        ]
        return candles
    }
}
