//
//  StocksViewModel.swift
//  StocksAcademy
//
//  Created by bovsheva on 25.07.2022.
//

import Foundation
import Combine
import SwiftUI


final class StocksViewModel: ObservableObject {
    
    /// Published value of the stored stock symbols
    @Published var storedStockSymbols: [SymbolData]  = [SymbolData]()
    
    @Published var stockSymbolItems: [String : StocksAcademy.StockSymbolItem] = [:]
    
    @Published var bitcoinCandles: SymbolStockCandles = SymbolStockCandles()
    
    @Published var ethereumCandles: SymbolStockCandles = SymbolStockCandles()
    
    // MARK: - Private
    
    private enum Crypto: String {
        case bitcoin = "BTC"
        case ethereum = "ETH"
    }
    
    private var quoteViewModelStorage: [String : RealTimeQuoteViewModel] = [:]
    
    private let manager: StocksManagerProtocol
    
    /// Set of an 'AnyCancellable' to store all subscriptions
    private var subscriptions = Set<AnyCancellable>()
    
    private let forPreview: Bool
    
    // MARK: - init
    init(manager: StocksManagerProtocol, forPreview: Bool = false) {
        self.manager = manager
        
        self.forPreview = forPreview
        print("StocksViewModel: init")
        
        if forPreview == false {
            self.setupSymbolsSubscriptions()
            self.setupCryptoSubscriptions()
            self.updateStoredStockSymbols()
            self.updateCryptoStockSymbols()
        }
        else {
            self.stockSymbolItems = StocksAcademy.dummyStockSymbols()
        }
    }
    
    public func update() {
        if forPreview == false {
            self.updateStoredStockSymbols()
            self.updateCryptoStockSymbols()
        }
        else {
            self.stockSymbolItems = StocksAcademy.dummyStockSymbols()
        }
    }
    
    deinit {
        print("StocksViewModel: deinit")
    }
    
    // MARK: - Private functions
    private func setupCryptoSubscriptions() {
        
        self.$bitcoinCandles
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [unowned self] candlesData in
                
                let percentage = candlesData.getChangePercentage()
                
                self.stockSymbolItems[Crypto.bitcoin.rawValue] = StocksAcademy.StockSymbolItem(
                    symbol: Crypto.bitcoin.rawValue,
                    name: "Bitcoin",
                    currentPrice: candlesData.candles.first?.close ?? 0,
                    percentChange: percentage,
                    highPrice: candlesData.candles.first?.high ?? 0,
                    lowPrice: candlesData.candles.first?.low ?? 0,
                    openPrice: candlesData.candles.first?.open ?? 0,
                    previousClosePrice: 0,
                    color: percentage > 0 ? Color.green : Color.red,
                    chart: percentage > 0 ? "green-chart" : "red-chart",
                    image: Image("bitcoin"))
            })
            .store(in: &subscriptions)
        
        self.$ethereumCandles
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [unowned self] candlesData in
                
                let percentage = candlesData.getChangePercentage()
                
                self.stockSymbolItems[Crypto.ethereum.rawValue] = StocksAcademy.StockSymbolItem(
                    symbol: Crypto.ethereum.rawValue,
                    name: "Ethereum",
                    currentPrice: candlesData.candles.first?.close ?? 0,
                    percentChange: percentage,
                    highPrice: candlesData.candles.first?.high ?? 0,
                    lowPrice: candlesData.candles.first?.low ?? 0,
                    openPrice: candlesData.candles.first?.open ?? 0,
                    previousClosePrice: 0,
                    color: percentage > 0 ? Color.green : Color.red,
                    chart: percentage > 0 ? "green-chart" : "red-chart",
                    image: Image("ethereum"))
            })
            .store(in: &subscriptions)
    }
    
    private func setupSymbolsSubscriptions() {
        
        self.$storedStockSymbols
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [unowned self] symbols in
                _ = symbols.map { symbol in
                    
                    var vm = self.quoteViewModelStorage[symbol.symbol]
                    
                    if vm == nil {
                        
                        vm = RealTimeQuoteViewModel(
                            manager: self.manager,
                            symbol: symbol,
                            timeInterval: 10)
                        
                        self.quoteViewModelStorage[symbol.symbol] = vm
                    }
                    
                    guard let viewModel = vm else { return }
                    
                    // Deactivate real time refreshing
                    viewModel.activateRealTimeRefreshing.send(false)
                    
                    // Subscribe to the ViewModel
                    viewModel.stockRealTimeQuote
                        .receive(on: RunLoop.main)
                        .sink { [unowned self] quote in
                            self.stockSymbolItems[symbol.symbol] = StocksAcademy.StockSymbolItem(
                                symbol: symbol.symbol,
                                name: symbol.description,
                                currentPrice: quote.currentPrice,
                                percentChange: quote.percentChange,
                                highPrice: quote.highPrice,
                                lowPrice: quote.lowPrice,
                                openPrice: quote.openPrice,
                                previousClosePrice: quote.previousClosePrice,
                                color: quote.percentChange > 0 ? Color.green : Color.red,
                                chart: quote.percentChange > 0 ? "green-chart" : "red-chart",
                                image: Image(systemName: "dollarsign.circle.fill"))
                            
                        }
                        .store(in: &self.subscriptions)
                }
            })
            .store(in: &subscriptions)
    }
    
    private func updateCryptoStockSymbols() {
        
        self.manager.stockCandlesForCrypto(for: Crypto.bitcoin.rawValue, numberOfDays: 2)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("StocksWatchlistViewModel: completed with failure \(error)")
                }
            }, receiveValue: { [unowned self] candles in
                self.bitcoinCandles = candles
            })
            .store(in: &subscriptions)
        
        self.manager.stockCandlesForCrypto(for: Crypto.ethereum.rawValue, numberOfDays: 2)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("StocksWatchlistViewModel: completed with failure \(error)")
                }
            }, receiveValue: { [unowned self] candles in
                self.ethereumCandles = candles
            })
            .store(in: &subscriptions)
    }
    
    private func updateStoredStockSymbols() {
        
        self.manager.storedStockSymbols()
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [unowned self] stockSymbols in
                self.storedStockSymbols = stockSymbols
            })
            .store(in: &subscriptions)
    }
}

