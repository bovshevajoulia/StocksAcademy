//
//  RealTimeQuoteViewModel.swift
//  StocksAcademy
//
//  Created by bovsheva on 27.06.2022.
//

import Foundation

import Combine


/// This ViewModel has Timer subcription and reloads data in realtime
/// Also we can deactivate the autorefreshing via 'isActive' published property
final class RealTimeQuoteViewModel {
    
    // MARK: - Published values
    /// Published value of a stocks watch list results
    var stockRealTimeQuote = CurrentValueSubject<RealTimeQuote, Never>(RealTimeQuote())
    
    /// Published value
    var activateRealTimeRefreshing = PassthroughSubject<Bool, Never>()
    
    
    // MARK: - Private
    
    /// Symbol name for getting realtime stock data
    private var stockSymbol: SymbolData
    
    /// StocksManager to fetch stocks
    private let manager: StocksManagerProtocol
    
    /// Time interval for updating data in realtime
    private var timeInterval: TimeInterval
    
    /// Set of an 'AnyCancellable' to store all subscriptions
    private var subscriptions = Set<AnyCancellable>()
    
    private var timerSubscription: AnyCancellable?
    
    // MARK: - Public
    
    var symbolDescription: String{
        get {
            return stockSymbol.description
        }
    }
    
    /// Symbol name for getting realtime stock data
    var symbol: String {
        get {
            return stockSymbol.symbol
        }
    }
    
    // MARK: - Init
    init(manager: StocksManagerProtocol,
         symbol: SymbolData,
         timeInterval: TimeInterval = 10
    ) {
        self.manager = manager
        self.stockSymbol = symbol
        self.timeInterval = timeInterval
        
        
        print("RealTimeQuoteViewModel: init with \(self.stockSymbol)")
        
        self.updateStockRealTimeQuote()
        self.setupIsActive()
    }
    
    deinit {
        print("RealTimeQuoteViewModel: DEINIT: for \(self.stockSymbol)")
        
        // MARK: remove subscriptions
        _ = subscriptions.map { subscription in
            subscription.cancel()
        }
        
        self.cancelTimer()
    }
    
    private func setupIsActive() {
        
        activateRealTimeRefreshing
            .removeDuplicates()
            .sink(receiveValue: { [unowned self] activate in
                if activate {
                    self.setupTimer()
                }
                else {
                    self.cancelTimer()
                }
            })
            .store(in: &subscriptions)
    }
    
    private func cancelTimer() {
        self.timerSubscription?.cancel()
    }
    
    private func setupTimer() {
        // reset timer
        self.cancelTimer()
        
        self.timerSubscription = Timer.publish(every: timeInterval,
                      on: RunLoop.current,
                      in: RunLoop.Mode.common)
            .autoconnect()
            .receive(on: RunLoop.main)
            .sink { completion in
                
            } receiveValue: { [unowned self] timestamp in
                
                print("TIMER TICK for \(self.stockSymbol.symbol) at: \(timestamp)")
                
                self.updateStockRealTimeQuote()
            }
    }
    
    /// Update the real time data for a given symbol
    private func updateStockRealTimeQuote() {
        
        self.manager.stockRealTimeQuote(for: self.stockSymbol.symbol)
            .sink { [unowned self] completion in
                
                switch completion {
                    case .finished:
                        break
                    case .failure:
                        self.stockRealTimeQuote.send(RealTimeQuote())
                }
                
            } receiveValue: { [unowned self] realTimeQuote in
                self.stockRealTimeQuote.send(realTimeQuote)
            }
            .store(in: &subscriptions)
    }
}
