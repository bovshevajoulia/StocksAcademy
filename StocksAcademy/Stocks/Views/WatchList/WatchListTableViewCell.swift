//
//  WatchListTableViewCell.swift
//  StocksAcademy
//
//  Created by bovsheva on 19.06.2022.
//

import UIKit
import Combine
import SwiftUI

class WatchListTableViewCell: UITableViewCell {
    static let identifier = "WatchListTableViewCell"
    
    // MARK: - Private
    
    ///Symbol label
    private let symbolLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    ///Company label
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .secondaryLabel
        return label
    }()
    
    ///Price label
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textAlignment = .right
        return label
    }()
    
    ///Change label
    private let changeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .right
        label.textColor = .white
        
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 4
        
        return label
    }()
    
    /// Realtime ViewModel
    private var quoteViewModel: RealTimeQuoteViewModel?
    
    private var subscribtions = Set<AnyCancellable>()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.clipsToBounds = true
        
        // MARK:  1. Add custom subviews here before resizing
        addSubviews(
            symbolLabel,
            nameLabel,
            priceLabel,
            changeLabel
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public
    
    /// Preffered height for cell
    static let preferredHeight: CGFloat = 60
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // MARK: If we want to resizing subviews should call 'sizeToFit' before resizing
        symbolLabel.sizeToFit()
        nameLabel.sizeToFit()
        priceLabel.sizeToFit()
        changeLabel.sizeToFit()
        
        symbolLabel.frame = CGRect(
            x: separatorInset.left,
            y: (contentView.height - symbolLabel.height - nameLabel.height) / 2,
            width: symbolLabel.width,
            height: symbolLabel.height
        )
        
        nameLabel.frame = CGRect(
            x: separatorInset.left,
            y: symbolLabel.bottom,
            width: nameLabel.width,
            height: nameLabel.height
        )
        
        priceLabel.frame = CGRect(
            x: contentView.right - priceLabel.width - 10,
            y: CGFloat(contentView.height - priceLabel.height - changeLabel.height) / 2,
            width: priceLabel.width,
            height: priceLabel.height
        )
        
        let changeLabelWidth: CGFloat = 80
        changeLabel.frame = CGRect(
            x: contentView.right - changeLabelWidth - 10,
            y: priceLabel.bottom,
            width: changeLabelWidth,
            height: changeLabel.height
        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        symbolLabel.text = nil
        nameLabel.text = nil
        changeLabel.text = nil
        
        //TODO: reset chart
    }
    
    /// Configure view
    /// - Parameter viewModels: 'RealTimeQuoteViewModel'
    public func configure(with quoteViewModel: RealTimeQuoteViewModel
    ) {
        self.quoteViewModel = quoteViewModel
        
        self.setupViewModelSubscribtions()
        
        self.updateCell(with: quoteViewModel.stockRealTimeQuote.value)
    }
    
    private func setupViewModelSubscribtions() {
        
        self.quoteViewModel?.stockRealTimeQuote
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [unowned self] realTimeQuote in
                
                self.updateCell(with: realTimeQuote)
                
            })
            .store(in: &subscribtions)
    }
    
    private func updateCell(with quote: RealTimeQuote ) {
        self.prepareForReuse()
        self.nameLabel.text = self.quoteViewModel?.symbolDescription
        self.symbolLabel.text = self.quoteViewModel?.symbol
        
        self.priceLabel.text = .formatted(number: quote.currentPrice)
        
        let percentChange = quote.change
        
        self.changeLabel.text = .formatted(number: percentChange) + " %"
        self.changeLabel.backgroundColor = percentChange > 0 ? .systemGreen : .systemRed
    }
}
