//
//  StocksManager.swift
//  StocksAcademy
//
//  Created by bovsheva on 19.06.2022.
//

import Foundation
import Combine
import SwiftUI

///Object to manage API calls
final class StocksManager: StocksManagerProtocol {
    
    // MARK: - Private
    
    private let network: NetworkServiceProtocol
    private let persistent: PersistentManagerProtocol
    
    /// API Endpoints
    private enum Endpoint: String {
        case search
        case news
        case quote
        case companyNews = "company-news"
        case stockCandle = "stock/candle"
        case stockMetric = "stock/metric"
        case cryptoCandle = "crypto/candle"
    }
    
    private enum NewsType {
        case marketNews
        case companyNews(symbol: String)
    }
    
    public enum Crypto: String {
        case bitcoin = "BINANCE:BTCUSDT"
        case ethereum = "BINANCE:ETHUSDT"
    }
    
    /// Constants
    private struct Constants {
        static let apiKey = "casr2kiad3ibmbnom1p0"
        static let sendboxApiKey = "sandbox_casr30iad3ibmbnom1v0"
        static let baseUrl = "https://finnhub.io/api/v1/"
        static let day: TimeInterval = 3600 * 24
    }
    
    // MARK: - Init
    
    init(network: NetworkServiceProtocol = NetworkService(),
         persistent: PersistentManagerProtocol = PersistentManager()
    ) {
        self.network = network
        self.persistent = persistent
        print("StocksManager: init")
    }
    
    // MARK: - Public functions
    
    /// Fetch default stocks list of symbols
    /// We can fetch from the network (REST API) or from the local storage.
    /// - Returns: 'AnyPublisher' type with '[String]' data
    public func storedStockSymbols() -> AnyPublisher<[SymbolData], Never> {
        
        return Future { [unowned self] promise in
            DispatchQueue.global(qos: .userInteractive).async {
                
                let data = self.persistent.storedSymbols()
                
                promise(.success(data))
            }
        }.eraseToAnyPublisher()
    }
    
    
    /// Remove stock simbol from the watchlist
    /// - Parameter symbol: symbol name
    /// - Returns: 'AnyPublisher' type with '[SymbolData]' data
    public func removeStoredStockSymbol(symbol: String) -> AnyPublisher<[SymbolData], Never> {
        
        return Future { [unowned self] promise in
            DispatchQueue.global(qos: .userInteractive).async {
                
                let data = self.persistent.remove(symbol: symbol)
                
                promise(.success(data))
            }
        }.eraseToAnyPublisher()
    }
    
    
    /// Add new stock simbol to the watchlist
    /// - Parameter symbol: symbol name
    /// - Returns: 'AnyPublisher' type with '[SymbolData]' data
    public func addStockSymbol(symbol: SymbolData) -> AnyPublisher<[SymbolData], Never> {
        
        return Future { [unowned self] promise in
            DispatchQueue.global(qos: .userInteractive).async {
                
                let data = self.persistent.add(symbol: symbol)
                
                promise(.success(data))
            }
        }.eraseToAnyPublisher()
    }
    
    /// Function for searching stock symbols
    /// - Parameters:
    ///   - query: Query string
    ///   - completion: completion handler
    public func search(
        query: String,
        completion: @escaping (Result<SearchResponse, APIError>) -> Void
    ) {
        guard query.isEmpty == false,
              let safeQuery = query.addingPercentEncoding(
                withAllowedCharacters: .urlQueryAllowed
              ) else {
                  return
              }
        
        let url = url(for: .search, queryParams: ["q" : safeQuery])
        
        network.fetch(
            SearchResponse.self,
            url: url,
            complition: completion)
    }
    
    /// Function to transform 'search' function result to 'AnyPublisher' result
    /// - Parameter query: Query string
    /// - Returns: 'AnyPublisher' with results
    public func searchStockSymbols(with query: String) -> AnyPublisher<[SearchResult], APIError> {
        
        return Future { [weak self] promise in
            
            self?.search(query: query) { result in
                
                switch result {
                        
                    case .failure(let error):
                        promise(.failure(error))
                        
                    case .success(let response):
                        promise(.success(response.result))
                }
            }
        }
        .eraseToAnyPublisher() // to expose an instance of 'AnyPublisher' to the downstream subscribers
    }
    
    /// Fetch stock candles for a given symbol
    /// - Parameters:
    ///   - symbol: Stock symbol string
    ///   - numberOfDays: Days for fetching stock data
    /// - Returns: 'AnyPublisher' type with 'StockCandles' data and 'APIError'
    public func stockCandles(for symbol: String,
                             numberOfDays: TimeInterval = 1
                             
    ) -> AnyPublisher<SymbolStockCandles, APIError> {
        
        return Future { [weak self] promise in
            
            let today = Date()
            let prior = today.addingTimeInterval(-(Constants.day * numberOfDays))
            
            self?.network.fetch(StockCandleResponse.self,
                                url: self?.url(
                                    for: .stockCandle,
                                       queryParams: [
                                        "symbol": symbol,
                                        "resolution": "1",
                                        "from": "\(Int(prior.timeIntervalSince1970))",
                                        "to": "\(Int(today.timeIntervalSince1970))"
                                       ]
                                )
            ) { result in
                switch result {
                        
                    case .failure(let error):
                        print("StocksManager: stockCandles: error: \(error.localizedDescription)")
                        promise(.failure(error))
                        
                    case .success(let response):
                        let data = SymbolStockCandles(
                            symbol: symbol,
                            candles: response.candleSticks
                        )
                        promise(.success(data))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    /// Fetch stock candles for a given crypto symbol
    /// - Parameters:
    ///   - symbol: Crypto stock symbol
    ///   - numberOfDays: Days for fetching stock data
    ///   We fetch data for 2 days to calculate the 'change percentage' value (for the chart color)
    /// - Returns: 'AnyPublisher' type with 'StockCandles' data and 'APIError'
    public func stockCandlesForCrypto(for symbol: String,
                             numberOfDays: TimeInterval = 2
                             
    ) -> AnyPublisher<SymbolStockCandles, APIError> {
        
        return Future { [weak self] promise in
            
            let today = Date()
            let prior = today.addingTimeInterval(-(Constants.day * numberOfDays))
            
            var symbolParam: Crypto = .bitcoin
            
            switch symbol {
                    
                case "BTC":
                    symbolParam = .bitcoin
                case "ETH":
                    symbolParam = .ethereum
                default:
                    promise(.failure(APIError.badUrl))
            }

            
            self?.network.fetch(StockCandleResponse.self,
                                url: self?.url(
                                    for: .cryptoCandle,
                                       queryParams: [
                                        "symbol": symbolParam.rawValue,
                                        "resolution": "1",
                                        "from": "\(Int(prior.timeIntervalSince1970))",
                                        "to": "\(Int(today.timeIntervalSince1970))"
                                       ]
                                )
            ) { result in
                switch result {
                        
                    case .failure(let error):
                        print("StocksManager: stockCandles: error: \(error.localizedDescription)")
                        promise(.failure(error))
                        
                    case .success(let response):
                        let data = SymbolStockCandles(
                            symbol: symbol,
                            candles: response.candleSticks
                        )
                        promise(.success(data))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    
    /// Fetch stock realtime quote data for a given symbol
    /// - Parameters:
    ///   - symbol: Stock symbol string
    /// - Returns: 'AnyPublisher' type with 'RealTimeQuote' data and 'APIError'
    public func stockRealTimeQuote(for symbol: String) -> AnyPublisher<RealTimeQuote, APIError> {
        
        return Future { [weak self] promise in
            
            self?.network.fetch(RealTimeQuote.self,
                                url: self?.url(for: .quote,
                                       queryParams: ["symbol": symbol]
                                )
            ) { result in
                
                switch result {
                        
                    case .failure(let error):
                        print("StocksManager: stockRealTimeQuote: error: \(error.localizedDescription)")
                        promise(.failure(error))
                        
                    case .success(let response):
                        
                        promise(.success(response))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    /// Fetch stock metrics for a given symbol
    /// - Parameters:
    ///   - symbol: Stock symbol string
    /// - Returns: 'AnyPublisher' type with 'SymbolStockMetrics' data and 'APIError'
    public func stockMetrics(for symbol: String) -> AnyPublisher<SymbolStockMetrics, APIError> {
        
        return Future { [weak self] promise in
            
            self?.network.fetch(StockMetricsResponse.self,
                                url: self?.url(for: .stockMetric,
                                       queryParams: ["symbol": symbol, "metric": "all"]
                                )
            ) { result in
                
                switch result {
                        
                    case .failure(let error):
                        print("StocksManager: stockMetrics: error: \(error.localizedDescription)")
                        promise(.failure(error))
                        
                    case .success(let response):
                        let data = SymbolStockMetrics(
                            symbol: symbol,
                            metrics: response.metric
                        )
                        promise(.success(data))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    
    /// Fetch company news for a given symbol
    /// - Parameter symbol: symbol name
    /// - Returns: 'AnyPublisher' type with '[NewsStory]' data and 'APIError'
    public func companyNews(for symbol: String) -> AnyPublisher<[NewsStory], APIError> {
        
        return self.marketNews(for: .companyNews(symbol: symbol))
    }
    
    /// Fetch top stories news
    /// - Returns: 'AnyPublisher' type with '[NewsStory]' data and 'APIError'
    public func topStoriesNews() -> AnyPublisher<[NewsStory], APIError> {
        
        return self.marketNews(for: .marketNews)
    }
    
    // MARK: - Private functions
    
    private func marketNews(for type: NewsType) -> AnyPublisher<[NewsStory], APIError> {
        
        return Future { [unowned self] promise in
            
            var url: String = ""
            
            switch type {
                
                case .companyNews(let symbol):
                    
                    let today = Date()
                    let backDate = today.addingTimeInterval(-(Constants.day * 1))
                    url = self.url(
                        for: .companyNews,
                        queryParams: [
                            "symbol": symbol,
                            "from": DateFormatter.newsDateFormatter.string(from: backDate),
                            "to": DateFormatter.newsDateFormatter.string(from: today)
                        ]
                    )
                
                case .marketNews:
                    url = self.url(for: .news, queryParams: ["category": "general"])
            }
            
            self.network.fetch([NewsStory].self, url: url) { result in
                
                switch result {
                        
                    case .failure(let error):
                        print("StocksManager: marketNews: error: \(error.localizedDescription)")
                        promise(.failure(error))
                        
                    case .success(let response):
                        promise(.success(response))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    /// Create url for the given endpoint
    /// - Parameters:
    ///   - endpoint: Endpoint to create for
    ///   - queryParams: Additional query parameters
    /// - Returns: String url representation
    private func url(
        for endpoint: Endpoint,
        queryParams: [String: String] = [:]
    ) -> String {
        
        var urlString = Constants.baseUrl + endpoint.rawValue
        
        var queryItems = [URLQueryItem]()
        
        // Add any parameters
        for (name, value) in queryParams {
            queryItems.append(.init(name: name, value: value))
        }
        
        // Add token
        queryItems.append(.init(name: "token", value: Constants.apiKey))
        
        // Convert query items to suffix string
        urlString += "?" + queryItems.map { "\($0.name)=\($0.value ?? "")" }.joined(separator: "&")
        
        return urlString
    }
}
