//
//  StockMetricsViewModel.swift
//  StocksAcademy
//
//  Created by bovsheva on 13.07.2022.
//

import Foundation

import Combine

final class StockMetricsViewModel {
    
    /// Published value of a stocks news stories
    var stockMetricsViewModel = CurrentValueSubject<SymbolStockMetrics, Never>(SymbolStockMetrics())
    
    // MARK: - Private
    private let stockSymbol: SymbolData
    
    /// StocksManager to fetch stocks
    private let manager: StocksManagerProtocol
    
    /// Set to save all subscriptions
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Init
    init(manager: StocksManagerProtocol, symbol: SymbolData) {
        self.manager = manager
        self.stockSymbol = symbol
        self.updateStockMetrics()
    }
    
    deinit {
        
        // MARK: remove subscriptions
        _ = subscriptions.map { subscription in
            subscription.cancel()
        }
    }
    
    /// Update the stock news data for a given symbol
    private func updateStockMetrics() {
        
        self.manager.stockMetrics(for: self.stockSymbol.symbol)
            .sink { [unowned self] completion in
                
                switch completion {
                    case .finished:
                        break
                    case .failure:
                        self.stockMetricsViewModel.send(SymbolStockMetrics())
                }
                
            } receiveValue: { [unowned self] metrics in
                self.stockMetricsViewModel.send(metrics)
            }
            .store(in: &subscriptions)
    }
}
