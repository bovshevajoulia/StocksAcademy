//
//  NewsHeaderView.swift
//  DreamBank
//
//  Created by bovsheva on 13.07.2022.
//

import UIKit
import SwiftUI
import Combine

class NewsHeaderView: UITableViewHeaderFooterView {
    static let identifier = "NewsHeaderView"
    static let prefferedHeight: CGFloat = 300
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// Price label
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        return label
    }()
    
    /// Change label
    private let changeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        return label
    }()
    
    /// ChartView
    private let chartView: StockChartView = {
        let chart = StockChartView()
        chart.backgroundColor = .systemBackground
        chart.translatesAutoresizingMaskIntoConstraints = false
        return chart
    }()
    
    /// ViewModels
    private var viewModel: RealTimeQuoteViewModel?
    
    /// Subscriptions
    private var subscribtions = Set<AnyCancellable>()
    
    private var chartColor = UIColor.red
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.addSubviews(titleLabel,
                                subtitleLabel,
                                priceLabel,
                                changeLabel,
                                chartView)
        
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupTitleLabel()
        self.setupSubtitleLabel()
        self.setupPriceLabel()
        self.setupChangeLabel()
        self.setupChartView()
    }
    
    private func setupTitleLabel() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        ])
    }
    
    private func setupSubtitleLabel() {
        NSLayoutConstraint.activate([
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 10),
            subtitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 25)
        ])
    }
    
    private func setupPriceLabel() {
        NSLayoutConstraint.activate([
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            priceLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        ])
    }
    
    private func setupChangeLabel() {
        NSLayoutConstraint.activate([
            changeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            changeLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10)
        ])
    }
    
    
    private func setupChartView() {
        NSLayoutConstraint.activate([
            chartView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            chartView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            chartView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            chartView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        subtitleLabel.text = nil
        priceLabel.text = nil
        changeLabel.text = nil
    }
    
    // MARK: - Private
    private func setupViewModelSubscribtions() {
        
        self.viewModel?.stockRealTimeQuote
            .receive(on: RunLoop.main)
            .sink { [unowned self] _ in
                self.update()
            }
            .store(in: &subscribtions)
    }
    
    private func update() {
        guard let vm = self.viewModel else {
            return
        }
        let percentChange = vm.stockRealTimeQuote.value.change
        self.priceLabel.text = .formatted(number: vm.stockRealTimeQuote.value.currentPrice)
        self.changeLabel.text = .formatted(number: percentChange) + " %"
        self.changeLabel.textColor = percentChange > 0 ? UIColor.green : UIColor.red
        self.chartColor = percentChange > 0 ? UIColor.green : UIColor.red
    }
    
    public func configure(with viewModel: RealTimeQuoteViewModel,
                          candlesViewModel: StockCandlesViewModel) {
        self.viewModel = viewModel
        
        titleLabel.text = viewModel.symbol
        subtitleLabel.text = viewModel.symbolDescription
        self.update()
        self.chartView.configure(with: candlesViewModel,
                                 chartColor: self.chartColor)
    }
}
