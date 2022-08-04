//
//  MarketNewsViewModel.swift
//  StocksAcademy
//
//  Created by bovsheva on 27.07.2022.
//

import Foundation
import Combine
import SwiftUI


final class MarketNewsViewModel: ObservableObject {
    
    /// Published value
    @Published var isLoading: Bool = false
    @Published var errorMessage: String = ""
    
    @Published var stockNewsStories: [NewsStory]  = [NewsStory]()
    @Published var reload: Bool = false
    
    private let manager: StocksManagerProtocol
    
    /// Set of an 'AnyCancellable' to store all subscriptions
    private var subscriptions = Set<AnyCancellable>()
    
    private let forPreview: Bool
    
    // MARK: - init
    init(manager: StocksManagerProtocol, forPreview: Bool = false) {
        self.manager = manager
        
        self.forPreview = forPreview
        print("MarketNewsViewModel: init")
        
        self.$reload
            .removeDuplicates()
            .sink(receiveValue: { [unowned self] value in
            if value {
                self.update()
            }
        })
            .store(in: &subscriptions)
        
        self.updateStockNews()
    }
    
    deinit {
        print("MarketNewsViewModel: deinit")
    }
    
    // MARK: - Public
    public func update() {
        if forPreview == false {
            self.updateStockNews()
        }
        else {
            self.stockNewsStories = [NewsStory.dummyNewsStory()]
        }
    }
    
    // MARK: - Private
    /// Update the stock news
    private func updateStockNews() {
        
        self.isLoading = true
        self.errorMessage = ""
        
        self.manager.topStoriesNews()
            .receive(on: RunLoop.main)
            .sink { [unowned self] completion in
                
                self.isLoading = false
                
                switch completion {
                    case .finished:
                        self.errorMessage = ""
                        break
                    case .failure(let error):
                        self.errorMessage = error.localizedDescription
                        self.stockNewsStories = [NewsStory]()
                }
                
            } receiveValue: { [unowned self] newsStories in
                self.isLoading = false
                self.errorMessage = ""
                self.stockNewsStories = newsStories[0...10].map({ $0 })
            }
            .store(in: &subscriptions)
    }
}
