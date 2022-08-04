//
//  StockCandlesViewModel.swift
//  StocksAcademy
//
//  Created by bovsheva on 28.06.2022.
//

import Foundation
import Combine


final class StockCandlesViewModel {
    
    // MARK: - Published values
    
    /// Published value of state
    var isLoading = CurrentValueSubject<Bool, Never>(false)
    
    /// Published value of error
    var errorMessage = CurrentValueSubject<String, Never>("")
    
    /// Published value of a stock candles for a given symbol
    var symbolStockCandles = CurrentValueSubject<SymbolStockCandles, Never>(SymbolStockCandles())
    
    
    // MARK: - Private
    
    /// StocksManager to fetch stocks
    private let manager: StocksManagerProtocol
    
    /// Symbol name for getting stock candles data
    private var stockSymbol: SymbolData
    
    
    /// Set of an 'AnyCancellable' to store all subscriptions
    private var subscriptions = Set<AnyCancellable>()
    
    
    // MARK: - Public
    var symbolDescription: String {
        get {
            stockSymbol.description
        }
    }
    
    var symbol: String {
        get {
            stockSymbol.symbol
        }
    }
    
    // MARK: - Init
    init(manager: StocksManagerProtocol,
         stockSymbol: SymbolData
    ) {
        self.manager = manager
        self.stockSymbol = stockSymbol
        
        print("StockCandlesViewModel: init with \(self.stockSymbol)")
        
        self.setupLoading()
        self.updateStockCandles()
    }
    
    deinit {
        print("StockCandlesViewModel: DEINIT: for \(self.stockSymbol)")
        
        // MARK: remove subscriptions
        _ = subscriptions.map { subscription in
            subscription.cancel()
        }
    }
    
    private func setupLoading() {
        self.isLoading.sink { [unowned self] loading in
            if loading {
                self.errorMessage.value = ""
            }
        }
        .store(in: &subscriptions)
    }
    
    /// Update the stock candles data for a given symbol
    private func updateStockCandles() {
        
        self.isLoading.send(true)
        
        self.manager.stockCandles(for: self.stockSymbol.symbol,
                                     numberOfDays: 7)
            .sink(receiveCompletion: { [unowned self] completion in
                
                self.isLoading.send(false)
                
                switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("StockCandlesViewModel: updateStockCandles: error \(error)")
                        self.errorMessage.send(error.localizedDescription)
                }
                
            }, receiveValue: { [unowned self] symbolStockCandles in
                self.isLoading.send(false)
                self.symbolStockCandles.send(symbolStockCandles)
            })
            .store(in: &subscriptions)
    }
}
