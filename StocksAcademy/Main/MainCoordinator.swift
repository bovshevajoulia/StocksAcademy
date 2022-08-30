//
//  MainCoordinator.swift
//  StocksAcademy
//
//  Created by bovsheva on 15.07.2022.
//

import Foundation
import SwiftUI
import Combine

final class MainCoordinator: Coordinator {
    
    // MARK: - Private
    private let goToStock: CurrentValueSubject<Bool,Never>
    
    private let stockManager = StocksManager()
    
    private lazy var homeViewModel = AcademyViewModel(manager: StocksAcademyManager())
    private lazy var stocksViewModel = StocksViewModel(manager: stockManager)
    private lazy var stocksNewsViewModel = MarketNewsViewModel(manager: stockManager)
    
    private let stateManager = StateManager()
    
    /// Set of an 'AnyCancellable' to store all subscriptions
    private var subscriptions = Set<AnyCancellable>()
    
    init(goToStock: CurrentValueSubject<Bool,Never>) {
        self.goToStock = goToStock
        
        self.setupSubscriptions()
    }
    
    // MARK: - Public
    public var rootViewController: UIViewController?
    
    func start() {
        
        let view = MainView(homeViewModel: homeViewModel,
                            stocksViewModel: stocksViewModel,
                            marketNewsViewModel: stocksNewsViewModel,
                            stateManager: stateManager)
        
        rootViewController = UIHostingController(rootView: view)
    }
    
    func dismiss() {
        _ = subscriptions.map { $0.cancel() }
    }
    
    private func setupSubscriptions() {
        
        stateManager.$tabPlusTapped
            .receive(on: RunLoop.main)
            .sink { value in
                if value {
                    self.goToStock.send(true)
                }
            }
            .store(in: &subscriptions)
    }
}
