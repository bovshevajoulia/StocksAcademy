//
//  StockNewsViewModel.swift
//  StocksAcademy
//
//  Created by bovsheva on 13.07.2022.
//

import Foundation
import Combine

final class StockNewsViewModel {
    
    /// Published value of state
    var isLoading = CurrentValueSubject<Bool, Never>(false)
    
    /// Published value of error
    var errorMessage = CurrentValueSubject<String, Never>("")
    
    /// Published value of a stocks news stories
    var stockNewsStories = CurrentValueSubject<[NewsStory], Never>([NewsStory]())
    
    
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
        
        self.setupLoading()
        self.updateStockNews()
    }
    
    deinit {
        
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
    
    /// Update the stock news data for a given symbol
    private func updateStockNews() {
        self.isLoading.send(true)
        self.manager.companyNews(for: self.stockSymbol.symbol)
            .sink { [unowned self] completion in
                self.isLoading.send(false)
                switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        self.errorMessage.send(error.localizedDescription)
                        self.stockNewsStories.send([NewsStory]())
                }
                
            } receiveValue: { [unowned self] newsStories in
                self.isLoading.send(false)
                self.stockNewsStories.send(newsStories)
            }
            .store(in: &subscriptions)
    }
}
