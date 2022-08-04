//
//  StockDetailsViewController.swift
//  DreamBank
//
//  Created by bovsheva on 13.07.2022.
//

import UIKit
import Combine
import SafariServices

class StockDetailsViewController: UIViewController {
    
    /// ViewModels
    private var quoteViewModel: RealTimeQuoteViewModel
    private var candlesViewModel: StockCandlesViewModel
    private var newsViewModel: StockNewsViewModel
    
    /// Subscriptions
    private var subscribtions = Set<AnyCancellable>()
    
    /// TableView
    private let tableView: UITableView = {
        let table = UITableView()
        // register Header and Cell
        table.register(NewsHeaderView.self,
                       forHeaderFooterViewReuseIdentifier: NewsHeaderView.identifier)
        table.register(NewsTableViewCell.self,
                       forCellReuseIdentifier: NewsTableViewCell.identifier)
        
        return table
    }()
    
    private var currentRowCount = 0
    
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
    
    // MARK: - Init
    init(quoteViewModel: RealTimeQuoteViewModel,
         candlesViewModel: StockCandlesViewModel,
         newsViewModel: StockNewsViewModel) {
        
        self.quoteViewModel = quoteViewModel
        self.candlesViewModel = candlesViewModel
        self.newsViewModel = newsViewModel
        
        super.init(nibName: nil, bundle: nil)
        
        print("StockDetailsViewController: init")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        self.setupViewModelSubscribtions()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // MARK: Setup table bounds to view bounds
        tableView.frame = view.bounds
        
        layoutPlaceholder(placeholder: loadingView)
        layoutPlaceholder(placeholder: errorView)
    }
    
    // MARK: - Private
    private func setupViewModelSubscribtions() {
        
        self.newsViewModel.isLoading
            .receive(on: RunLoop.main)
            .removeDuplicates()
            .sink { [unowned self] loading in
                self.updateLoadingView(with: loading)
            }
            .store(in: &subscribtions)
        
        self.newsViewModel.errorMessage
            .receive(on: RunLoop.main)
            .removeDuplicates()
            .sink { [unowned self] error in
                self.updateErrorView(with: error)
            }
            .store(in: &subscribtions)
        
        self.newsViewModel.stockNewsStories
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [unowned self] _ in
                self.currentRowCount = self.newsViewModel.stockNewsStories.value.count
                self.tableView.reloadData()
            })
            .store(in: &subscribtions)
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

extension StockDetailsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.currentRowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier,
                                                       for: indexPath) as? NewsTableViewCell
        else {
            fatalError("StockDetailsViewController: cellForRowAt: Upcasting is failed")
        }
        let newsStory = newsViewModel.stockNewsStories.value[indexPath.row]
        cell.configure(with: newsStory)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return NewsTableViewCell.prefferedHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: NewsHeaderView.identifier) as? NewsHeaderView
        else {
            fatalError("StockDetailsViewController: viewForHeaderInSection: Upcasting is failed")
        }
        header.configure(with: quoteViewModel,
                         candlesViewModel: candlesViewModel)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return NewsHeaderView.prefferedHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let url = URL(string: newsViewModel.stockNewsStories.value[indexPath.row].url)
        else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true, completion: nil)
    }
}
