//
//  StocksSearchViewModel.swift
//  StocksAcademy
//
//  Created by bovsheva on 21.06.2022.
//

import Foundation
import Combine

final class StocksSearchViewModel {
    
    /// Published value of state
    var isLoading = CurrentValueSubject<Bool, Never>(false)
    
    /// Published value of error
    var errorMessage = CurrentValueSubject<String, Never>("")
    
    /// Published value of a stocks search results
    var stocksSearchResults = CurrentValueSubject<[SearchResult], Never>([SearchResult]())
    
    /// Published value of a query string
    var searchText = CurrentValueSubject<String, Never>("")
    
    
    // MARK: - Private
    
    /// StocksManager to fetch stocks
    private let manager: StocksManagerProtocol
    
    /// Set to save all subscriptions
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Init
    init(manager: StocksManagerProtocol) {
        self.manager = manager
        
        setupSearchText()
    }
    
    deinit {
        
        // MARK: remove subscriptions
        _ = subscriptions.map { subscription in
            subscription.cancel()
        }
    }
    
    // MARK: - Private
    
    /// Setup subscription to the search query upstream data flow (upstream stream from VC layer)
    private func setupSearchText() {
        self.errorMessage.value = ""
        
        searchText
            .dropFirst() // drop initial 'searchText' ("") value
            .removeDuplicates()
            .debounce(for: .milliseconds(300) , scheduler: RunLoop.main)
            .map { [unowned self] text -> AnyPublisher<[SearchResult], APIError> in
                
                self.isLoading.send(true)
                
                // return value of this call is 'Publisher'. We should redirect this flow stream (downstream) to VC
                return self.manager.searchStockSymbols(with: text)
                    .eraseToAnyPublisher()
                
            }                   // here we have stream in the stream
            .compactMap({ $0 }) // remove(unwrap) Optional
            .switchToLatest()   // republished the obtained result ('[SearchResults]')
            .sink(receiveCompletion: { [unowned self] completion in
                
                self.isLoading.send(false)
                
                switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        self.stocksSearchResults.send([SearchResult]())
                        self.errorMessage.send(error.localizedDescription)

                }
                
            }, receiveValue: { [unowned self] results in
                
                self.isLoading.send(false)
                self.stocksSearchResults.send(results)
            })
            .store(in: &subscriptions)
    }
    
}
