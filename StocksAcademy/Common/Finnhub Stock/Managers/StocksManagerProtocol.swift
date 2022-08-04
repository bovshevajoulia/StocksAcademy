//
//  StockManagerProtocol.swift
//  StocksAcademy
//
//  Created by bovsheva on 19.06.2022.
//

import Foundation
import Combine

protocol StocksManagerProtocol {
    
    /// Fetch default stocks list of symbols
    /// We can fetch from the network (REST API) or from the local storage.
    /// - Returns: 'AnyPublisher' type with '[String]' data
    func storedStockSymbols() -> AnyPublisher<[SymbolData], Never>
    
    /// Remove stock simbol from the watchlist
    /// - Parameter symbol: symbol name
    /// - Returns: 'AnyPublisher' type with '[SymbolData]' data
    func removeStoredStockSymbol(symbol: String) -> AnyPublisher<[SymbolData], Never>
    
    /// Add new stock simbol to the watchlist
    /// - Parameter symbol: symbol name
    /// - Returns: 'AnyPublisher' type with '[SymbolData]' data
    func addStockSymbol(symbol: SymbolData) -> AnyPublisher<[SymbolData], Never>
    
    /// Function for searching stock symbols
    /// - Parameters:
    ///   - query: Query string
    ///   - completion: completion handler
    func search(
        query: String,
        completion: @escaping (Result<SearchResponse, APIError>) -> Void
    )
    
    /// Function to transform 'search' function result to 'AnyPublisher' result
    /// - Parameter query: Query string
    /// - Returns: 'AnyPublisher' with results
    func searchStockSymbols(with query: String) -> AnyPublisher<[SearchResult], APIError>
    
    /// Fetch stock candles for a given symbol
    /// - Parameters:
    ///   - symbol: Stock symbol string
    ///   - numberOfDays: Days for fetching stock data
    /// - Returns: 'AnyPublisher' type with 'StockCandles' data and 'APIError'
    func stockCandles(for symbol: String,
                      numberOfDays: TimeInterval
    ) -> AnyPublisher<SymbolStockCandles, APIError>
    
    /// Fetch stock candles for a given crypto symbol
    /// - Parameters:
    ///   - symbol: Crypto stock symbol ("BTC" or "ETH")
    ///   - numberOfDays: Days for fetching stock data
    ///   We fetch data for 2 days to calculate the 'change percentage' value (for the chart color)
    /// - Returns: 'AnyPublisher' type with 'StockCandles' data and 'APIError'
    func stockCandlesForCrypto(for symbol: String,
                             numberOfDays: TimeInterval
                             
    ) -> AnyPublisher<SymbolStockCandles, APIError>
    
    /// Fetch stock metrics for a given symbol
    /// - Parameters:
    ///   - symbol: Stock symbol string
    /// - Returns: 'AnyPublisher' type with 'SymbolStockMetrics' data and 'APIError'
    func stockMetrics(for symbol: String) -> AnyPublisher<SymbolStockMetrics, APIError>
    
    /// Fetch stock realtime quote data for a given symbol
    /// - Parameters:
    ///   - symbol: Stock symbol string
    /// - Returns: 'AnyPublisher' type with 'RealTimeQuote' data and 'APIError'
    func stockRealTimeQuote(for symbol: String) -> AnyPublisher<RealTimeQuote, APIError>
    
    /// Fetch company news for a given symbol
    /// - Parameter symbol: symbol name
    /// - Returns: 'AnyPublisher' type with '[NewsStory]' data and 'APIError'
    func companyNews(for symbol: String) -> AnyPublisher<[NewsStory], APIError>
    
    /// Fetch top stories news
    /// - Returns: 'AnyPublisher' type with '[NewsStory]' data and 'APIError'
    func topStoriesNews() -> AnyPublisher<[NewsStory], APIError>
}
