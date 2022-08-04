//
//  WatchListViewController.swift
//  StocksAcademy
//
//  Created by bovsheva on 19.06.2022.
//

import UIKit
import Combine

class WatchListViewController: UIViewController {
    
    // MARK: - Private
    
    ///Reference to the ViewModel
    private var viewModel: StocksListViewModel
    private var subscribtions = Set<AnyCancellable>()
    
    private var currentRowCount = 0
    
    /// Table to show Stocks list
    private let tableView: UITableView = {
        let table = UITableView()
        
        // register custom cell here
        table.register(WatchListTableViewCell.self,
                       forCellReuseIdentifier: WatchListTableViewCell.identifier)
        
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
        let view = makeErrorPlaceholder()
        view.isHidden = true
        return view
    }()
    
    // MARK: - Public
    public var showDetailsViewRequested: ((_ symbol: SymbolData) -> ())?
    
    // MARK: - Init
    init(viewModel: StocksListViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        print("WatchListViewController: init")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        // MARK: 1. setup subviews
        self.setupTableView()
        
        // MARK: 2. setup combine subscriptions
        self.setupViewModelSubscribtions()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.layoutPlaceholder(placeholder: loadingView)
        self.layoutPlaceholder(placeholder: errorView)
    }
    
    // MARK: - Private
    
    private func setupViewModelSubscribtions() {
        
        self.viewModel.isLoading
            .receive(on: RunLoop.main)
            .removeDuplicates()
            .sink { [unowned self] loading in
                self.updateLoadingView(with: loading)
            }
            .store(in: &subscribtions)
        
        
        self.viewModel.storedStockSymbols
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [unowned self] _ in
                self.currentRowCount = self.viewModel.storedStockSymbols.value.count
                self.tableView.reloadData()
            })
            .store(in: &subscribtions)
    }
    
    private func updateLoadingView(with show: Bool) {
        if show == true {
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
    
    private func setupTableView() {
        self.view.addSubview(tableView)
        self.tableView.frame = view.bounds
        self.tableView.backgroundColor = .systemBackground
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}

// MARK: - Table view delegate
extension WatchListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.currentRowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: WatchListTableViewCell.identifier,
            for: indexPath) as? WatchListTableViewCell
        else {
                fatalError("tableView:cellForRowAt: Failed to cast to WatchListTableViewCell")
            }
        
        let symbolData: SymbolData = self.viewModel.storedStockSymbols.value[indexPath.row]
        
        let quoteViewModel = self.viewModel.realTimeQuoteViewModel(for: symbolData.symbol)
        
        cell.configure(with: quoteViewModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return WatchListTableViewCell.preferredHeight
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        
        return UITableViewCell.EditingStyle.delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let symbolData: SymbolData = self.viewModel.storedStockSymbols.value[indexPath.row]
        
        if editingStyle == .delete {
            
            self.viewModel.deleteSymbol.send(symbolData.symbol)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let symbolData: SymbolData = self.viewModel.storedStockSymbols.value[indexPath.row]
        
        self.showDetailsViewRequested?(symbolData)
    }
}
