//
//  StocksManagerMock.swift
//  StocksAcademyTests
//
//  Created by bovsheva on 31.07.2022.
//

import Foundation
import Combine

@testable import StocksAcademy

class StocksManagerMock: StocksManagerProtocol {
    
    var stockSymbols: [SymbolData]?
    
    func storedStockSymbols() -> AnyPublisher<[SymbolData], Never> {
        return Future { promise in
            DispatchQueue.global(qos: .userInteractive).async {
                
                promise(.success(self.stockSymbols!))
            }
        }.eraseToAnyPublisher()
    }
    
    func removeStoredStockSymbol(symbol: String) -> AnyPublisher<[SymbolData], Never> {
        return Future { promise in
            DispatchQueue.global(qos: .userInteractive).async {
                self.stockSymbols!.removeAll { symbolData in
                    symbolData.symbol == symbol
                }
                promise(.success(self.stockSymbols!))
            }
        }.eraseToAnyPublisher()
    }
    
    func addStockSymbol(symbol: SymbolData) -> AnyPublisher<[SymbolData], Never> {
        return Future { promise in
            DispatchQueue.global(qos: .userInteractive).async {
                
                self.stockSymbols!.append(symbol)
                
                promise(.success(self.stockSymbols!))
            }
        }.eraseToAnyPublisher()
    }
    
    var searchResult: Result<SearchResponse, APIError>?
    
    func search(query: String, completion: @escaping (Result<SearchResponse, APIError>) -> Void) {
        completion(self.searchResult!)
    }
    
    var searchStockSymbolsResult: Result<[SearchResult], APIError>? = nil
    
    func searchStockSymbols(with query: String) -> AnyPublisher<[SearchResult], APIError> {
        return Future { promise in
            DispatchQueue.global(qos: .userInteractive).async {
                
                switch self.searchStockSymbolsResult! {
                        
                    case .failure(let error):
                        promise(.failure(error))
                        
                    case .success(let result):
                        promise(.success(result))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    var stockCandlesResult: Result<SymbolStockCandles, APIError>? = nil
    
    func stockCandles(for symbol: String, numberOfDays: TimeInterval) -> AnyPublisher<SymbolStockCandles, APIError> {
        return Future { promise in
            DispatchQueue.global(qos: .userInteractive).async {
                
                switch self.stockCandlesResult! {
                        
                    case .failure(let error):
                        promise(.failure(error))
                        
                    case .success(let result):
                        promise(.success(result))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func stockCandlesForCrypto(for symbol: String, numberOfDays: TimeInterval) -> AnyPublisher<SymbolStockCandles, APIError> {
        return Future { promise in
            DispatchQueue.global(qos: .userInteractive).async {
                
                switch self.stockCandlesResult! {
                        
                    case .failure(let error):
                        promise(.failure(error))
                        
                    case .success(let result):
                        promise(.success(result))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    var stockMetricsResult: Result<SymbolStockMetrics, APIError>? = nil
    
    func stockMetrics(for symbol: String) -> AnyPublisher<SymbolStockMetrics, APIError> {
        return Future { promise in
            DispatchQueue.global(qos: .userInteractive).async {
                
                switch self.stockMetricsResult! {
                        
                    case .failure(let error):
                        promise(.failure(error))
                        
                    case .success(let result):
                        promise(.success(result))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    var stockRealTimeQuoteResult: Result<RealTimeQuote, APIError>? = nil
    
    func stockRealTimeQuote(for symbol: String) -> AnyPublisher<RealTimeQuote, APIError> {
        return Future { promise in
            DispatchQueue.global(qos: .userInteractive).async {
                
                switch self.stockRealTimeQuoteResult! {
                        
                    case .failure(let error):
                        promise(.failure(error))
                        
                    case .success(let result):
                        promise(.success(result))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    var storiesNewsResult: Result<[NewsStory], APIError>? = nil
    
    func companyNews(for symbol: String) -> AnyPublisher<[NewsStory], APIError> {
        return Future { promise in
            DispatchQueue.global(qos: .userInteractive).async {
                
                switch self.storiesNewsResult! {
                        
                    case .failure(let error):
                        promise(.failure(error))
                        
                    case .success(let result):
                        promise(.success(result))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func topStoriesNews() -> AnyPublisher<[NewsStory], APIError> {
        return Future { promise in
            DispatchQueue.global(qos: .userInteractive).async {
                
                switch self.storiesNewsResult! {
                        
                    case .failure(let error):
                        promise(.failure(error))
                        
                    case .success(let result):
                        promise(.success(result))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    public func setUpEmptyData() {
        
        self.stockSymbols = []
        
        self.searchResult = Result.success(SearchResponse())
        
        self.searchStockSymbolsResult = Result.success([SearchResult]())
        
        self.stockCandlesResult = Result.success(SymbolStockCandles())
        
        self.stockMetricsResult = Result.success(SymbolStockMetrics())
        
        self.stockRealTimeQuoteResult = Result.success(RealTimeQuote())
        
        self.storiesNewsResult = Result.success([NewsStory]())
    }
    
    public func dummySymbol() -> SymbolData {
        return SymbolData(description: "Starbucks Corp.", symbol: "SBUX")
    }
}
