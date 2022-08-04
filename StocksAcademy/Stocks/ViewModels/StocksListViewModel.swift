//
//  StocksListViewModel.swift
//  StocksAcademy
//
//  Created by bovsheva on 23.06.2022.
//

import Foundation

import Combine
import SwiftUI

final class StocksListViewModel {
    
    /// Published value of state
    var isLoading = CurrentValueSubject<Bool, Never>(false)
    
    /// Published value of the stored stock symbols
    var storedStockSymbols = CurrentValueSubject<[SymbolData], Never>([SymbolData]())
    
    // PassthroughSubject
    // use for starting action/process, equivalent to function
    
    /// Published value of a request to delete the symbol
    var deleteSymbol = PassthroughSubject<String, Never>()
    
    /// Published value of a request to delete the symbol
    var addSymbol = PassthroughSubject<SymbolData, Never>()
    
    /// Published value
    var activateRealTimeRefreshing = PassthroughSubject<Bool, Never>()
    
    
    // MARK: - Private
    ///
    private var quoteViewModelStorage: [String : RealTimeQuoteViewModel] = [:]
    
    /// StocksManager to fetch stocks
    private let manager: StocksManagerProtocol
    
    /// Set of an 'AnyCancellable' to store all subscriptions
    private var subscriptions = Set<AnyCancellable>()
    
    ///TimeInterval for fetching realtime data
    private var autoupdateIntervall = TimeInterval(10)
    
    // MARK: - Init
    init(manager: StocksManagerProtocol) {
        self.manager = manager
        
        print("StocksListViewModel: init")
        
        self.updateStoredStockSymbols()
        self.setupAddSymbol()
        self.setupDeleteSymbol()
        self.setupActivateRealTimeRefreshing()
    }
    
    deinit {
        
        // MARK: remove subscriptions
        _ = subscriptions.map { subscription in
            subscription.cancel()
        }
    }
    
    
    /// Return 'RealTimeQuoteViewModel' instance if it exists
    /// Otherwise create new instance and store in 'realTimeQuoteViewModelStorage'
    /// - Parameter symbol: symbol
    /// - Returns: 'RealTimeQuoteViewModel' instance
    public func realTimeQuoteViewModel(for symbol: String) -> RealTimeQuoteViewModel {
        
        if let vm = self.quoteViewModelStorage[symbol] {
            return vm
        }
        else {
            guard let symbolData = self.storedStockSymbols.value.first(
                where: { $0.symbol == symbol }
            ) else {
                fatalError("StocksListViewModel: realTimeQuoteViewModel: Symbol is not found")
            }
            
            let vm = RealTimeQuoteViewModel(
                manager: self.manager,
                symbol: symbolData,
                timeInterval: autoupdateIntervall)
            
            // Activate real time refreshing
            vm.activateRealTimeRefreshing.send(true)
            
            self.quoteViewModelStorage[symbol] = vm
            
            return vm
        }
    }
    
    // MARK: - Private finctions
    private func setupActivateRealTimeRefreshing() {
        
        self.activateRealTimeRefreshing
            .removeDuplicates()
            .sink { [unowned self] activate in
                self.quoteViewModelStorage.forEach { (key: String, value: RealTimeQuoteViewModel) in
                    value.activateRealTimeRefreshing.send(activate)
                }
            }.store(in: &subscriptions)
    }
    
    /// Creates subscription to the 'deleteSymbol' property
    private func setupDeleteSymbol() {
        
        self.deleteSymbol
            .sink(receiveValue: { [unowned self] symbol in
                
                self.manager.removeStoredStockSymbol(symbol: symbol)
                    .sink(receiveValue: { [unowned self] symbols in
                        
                        self.storedStockSymbols.send(symbols)
                    })
                    .store(in: &subscriptions)

            })
            .store(in: &subscriptions)
    }
    
    /// Creates subscription to the 'addSymbol' property
    private func setupAddSymbol() {
        
        self.addSymbol
            .sink(receiveValue: { [unowned self] symbol in
                
                self.manager.addStockSymbol(symbol: symbol)
                    .sink(receiveValue: { [unowned self] symbols in
                        
                        self.storedStockSymbols.send(symbols)
                    })
                    .store(in: &subscriptions)

            })
            .store(in: &subscriptions)
    }
    
    /// Update the 'storedStockSymbols'
    private func updateStoredStockSymbols() {
        
        self.isLoading.send(true)
        
        // update stored stock symbols from 'StocksManager' (this data could be fetched from the network or from the userdefaults. It is up to the 'StocksManager')
        self.manager.storedStockSymbols()
            .sink(receiveValue: { [unowned self] stockSymbols in
                self.isLoading.send(false)
                
                self.storedStockSymbols.send(stockSymbols)
            })
            .store(in: &subscriptions)
    }
}
