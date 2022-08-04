//
//  StockMetricsResponse.swift
//  StocksAcademy
//
//  Created by bovsheva on 25.06.2022.
//

import Foundation

/// Metrics response from API
struct StockMetricsResponse: Codable {
    let metric: Metrics
}

/// Financial metrics
struct Metrics: Codable {
    let tenDayAverageTradingVolume: Float
    let annualWeekHigh: Double
    let annualWeekLow: Double
    let annualWeekLowDate: String
    let annualWeekPriceReturnDaily: Float
    let beta: Float

    enum CodingKeys: String, CodingKey {
        case tenDayAverageTradingVolume = "10DayAverageTradingVolume"
        case annualWeekHigh = "52WeekHigh"
        case annualWeekLow = "52WeekLow"
        case annualWeekLowDate = "52WeekLowDate"
        case annualWeekPriceReturnDaily = "52WeekPriceReturnDaily"
        case beta = "beta"
    }
}
