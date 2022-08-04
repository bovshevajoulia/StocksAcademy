//
//  SearchResultsViewController.swift
//  StocksAcademy
//
//  Created by bovsheva on 19.06.2022.
//

import UIKit
import Combine

/// Controller with table to perform search results
class SearchResultsViewController: UIViewController {
    
    // MARK: - Private
    
    /// Table to show search results
    private let tableView: UITableView = {
        
        let table = UITableView()
        
        // MARK: register custom cell class here
        table.register(
            SearchResultTableViewCell.self,
            forCellReuseIdentifier: SearchResultTableViewCell.identifier
        )
        
        return table
    }()
    
    /// Loading placeholder view
    private lazy var loadingView: LoadingPlaceholderView = {
        let view = makeLoadingPlaceholder()
        view.isHidden = true
        return view
    }()
    
    /// Error placeholder view
    private lazy var errorView: ErrorPlaceholderView = {
        let view = makeErrorPlaceholder(with: "ant")
        view.isHidden = true
        return view
    }()
    
    /// References to the ViewModels
    private var searchViewModel: StocksSearchViewModel
    
    private var listViewModel: StocksListViewModel

    private var subscribtions = Set<AnyCancellable>()
    
    // MARK: - Public
    
    // MARK: - Init
    init(searchViewModel: StocksSearchViewModel,
         listViewModel: StocksListViewModel
    ) {
        self.searchViewModel = searchViewModel
        self.listViewModel = listViewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupTableView()
        
        // MARK: 2. setup combine subscriptions
        setupViewModelSubscribtions()
        
        
    }
    
    private func setupViewModelSubscribtions() {
        
        self.searchViewModel.stocksSearchResults
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                
                self?.tableView.reloadData()
            }
            .store(in: &subscribtions)
        
        self.searchViewModel.isLoading
            .removeDuplicates()
            .receive(on: RunLoop.main)
            .sink { [weak self] loading in
                self?.updateLoadingView(with: loading)
            }
            .store(in: &subscribtions)
        
        self.searchViewModel.errorMessage
            .receive(on: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] error in
                self?.updateErrorView(with: error)
            }
            .store(in: &subscribtions)
        
        self.listViewModel.storedStockSymbols
            .receive(on: RunLoop.main)
            .sink { [unowned self] _ in
                
                self.tableView.reloadData()
            }
            .store(in: &subscribtions)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // MARK: Setup table bounds to view bounds
        tableView.frame = view.bounds
        
        layoutPlaceholder(placeholder: loadingView)
        layoutPlaceholder(placeholder: errorView)
    }
    
    // MARK: - Private functions
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func updateLoadingView(with show: Bool) {
        if show {
            self.tableView.isHidden = true
            self.loadingView.isHidden = false
        }
        else {
            self.tableView.isHidden = false
            self.loadingView.isHidden = true
        }
    }
    
    private func updateErrorView(with error: String) {
        self.errorView.setDescription(for: error)
        
        if error.isEmpty {
            self.tableView.isHidden = false
            self.errorView.isHidden = true
        }
        else {
            self.tableView.isHidden = true
            self.errorView.isHidden = false
        }
    }
}


// MARK: - UITableViewDelegate, UITableViewDataSource
extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SearchResultTableViewCell.preferredHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchViewModel.stocksSearchResults.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SearchResultTableViewCell.identifier,
            for: indexPath
        ) as? SearchResultTableViewCell else {
            fatalError("tableView:cellForRowAt: Failed to cast to SearchResultTableViewCell")
        }
        
        let searchResult = self.searchViewModel.stocksSearchResults.value[indexPath.row]
        let isSymbolAdded = self.listViewModel.storedStockSymbols.value.contains(
            where: { $0.symbol == searchResult.symbol }
        )
        
        cell.configure(with: searchResult, addedButtonIsHidden: isSymbolAdded)
        
        cell.addNewSymbolActionRequested = { [weak self] symbol in
            
            guard let result = self?.searchViewModel.stocksSearchResults.value.first(
                where: { $0.symbol == symbol
                }) else { return }
            
            self?.listViewModel.addSymbol.send(SymbolData(description: result.description,
                                                          symbol: result.symbol))
        }
        return cell
    }
}
