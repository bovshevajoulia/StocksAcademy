//
//  StocksCoordinator.swift
//  StocksAcademy
//
//  Created by bovsheva on 16.06.2022.
//

import Foundation
import UIKit
import Combine
import SwiftUI

final class StocksCoordinator: NSObject, Coordinator {
    
    // MARK: - Private
    private let goToHome: CurrentValueSubject<Bool,Never>
    
    /// 'StocksManager'
    private let stocksManager: StocksManagerProtocol
    
    /// ViewModels
    private lazy var stocksListViewModel = StocksListViewModel(manager: stocksManager)
    
    private lazy var stocksSearchViewModel = StocksSearchViewModel(manager: stocksManager)
    
    // MARK: _ init
    init(goToHome: CurrentValueSubject<Bool,Never>,
         stocksManager: StocksManagerProtocol
    ) {
        self.goToHome = goToHome
        self.stocksManager = stocksManager
    }
    
    /// Watch list view to show the list of 'Stocks'
    private lazy var watchListViewController: WatchListViewController = {
        let vc = WatchListViewController(viewModel: stocksListViewModel)
        
        vc.navigationItem.title = "Stocks"
        
        self.setupHomeButton(viewController: vc)
        
        vc.showDetailsViewRequested = { [weak self] symbol in
            self?.showStockDetailsView(for: symbol)
        }
        
        return vc
    }()
    
    /// Detail view to show the 'Stocks' details
    
    // MARK: - Public
    
    var rootViewController: UINavigationController = {
        let vc = UINavigationController()
        
        return vc
    }()
    
    // MARK: - Coordinator
    
    // MARK: - Start flow
    func start() {
        
        self.setupSearchController()
        
        self.rootViewController.delegate = self
        self.rootViewController.setViewControllers([watchListViewController], animated: true)
    }
    
    // MARK: - dismiss flow
    func dismiss() {
        self.stocksListViewModel.activateRealTimeRefreshing.send(false)
    }
    
    // MARK: - Private
    @objc private func homeTapped() {
        self.goToHome.send(true)
    }

    private func showStockDetailsView(for symbol: SymbolData) {
        
        let vc = StockDetailsViewController(
            quoteViewModel: stocksListViewModel.realTimeQuoteViewModel(for: symbol.symbol),
            candlesViewModel: StockCandlesViewModel(manager: self.stocksManager, stockSymbol: symbol),
            newsViewModel: StockNewsViewModel(manager: self.stocksManager, symbol: symbol)
        )
        
        self.rootViewController.pushViewController(vc, animated: true)
    }
    
    private func setupSearchController() {
        let vc =  SearchResultsViewController(searchViewModel: stocksSearchViewModel,
                                              listViewModel: stocksListViewModel)
        
        let svc = UISearchController(searchResultsController: vc)
        
        svc.searchResultsUpdater = self
        self.watchListViewController.navigationItem.searchController = svc
    }
    
    private func setupHomeButton(viewController: UIViewController) {
        
        let image = UIImage(systemName: "house")
        viewController.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image,
                                                               style: .plain,
                                                               target: self,
                                                               action: #selector(homeTapped))
    }
}

// MARK: UINavigationControllerDelegate
extension StocksCoordinator: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController,
                              willShow viewController: UIViewController,
                              animated: Bool) {
        
        if viewController is StockDetailsViewController {
            
            self.stocksListViewModel.activateRealTimeRefreshing.send(false)
        
        } else if viewController is WatchListViewController {
            self.stocksListViewModel.activateRealTimeRefreshing.send(true)
        }
    }

}

// MARK: UISearchResultsUpdating
extension StocksCoordinator: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text,
              query.trimmingCharacters(in: .whitespaces).isEmpty == false
        else {
            return
        }
        
        // API call to perfom search
        // update SearchResultsViewController to show results
        self.stocksSearchViewModel.searchText.send(query)
    }
}
