//
//  SearchResultTableViewCell.swift
//  StocksAcademy
//
//  Created by bovsheva on 19.06.2022.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {
    
    static let identifier = "SearchResultTableViewCell"
    
    // MARK: - Private
    
    ///Symbol label
    private let symbolLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .systemGray
        return label
    }()
    
    ///Company label
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .systemGray
        return label
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("+ Watchlist", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.clipsToBounds = true
        
        // MARK:  1. Add custom subviews here before resizing
        addSubviews(
            symbolLabel,
            nameLabel,
            addButton
        )
        addButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // MARK: If we want to resizing subviews should call 'sizeToFit' before resizing
        symbolLabel.sizeToFit()
        nameLabel.sizeToFit()
        addButton.sizeToFit()
        
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
        
        let addButtonWidth: CGFloat = 100
        let addButtonHeight: CGFloat = 30
        addButton.frame = CGRect(
            x: contentView.right - addButtonWidth - 16,
            y: (contentView.height - addButtonHeight) / 2,
            width: addButtonWidth,
            height: addButtonHeight
        )
    }
    
    // MARK: - Private
    /// Handle add button tap
    @objc private func didTapAddButton() {
        
        guard let symbol = self.symbolLabel.text else { return }
        
        // Call delegate
        addNewSymbolActionRequested?(symbol)
    }
    
    // MARK: - Public
    
    public var showDetailsViewActionRequested: ((_ symbol: String) -> ())?
    public var addNewSymbolActionRequested: ((_ symbol: String) -> ())?
    
    
    /// Preffered height for cell
    static let preferredHeight: CGFloat = 60
    
    public func configure(with result: SearchResult, addedButtonIsHidden: Bool = false) {
        symbolLabel.text = result.symbol
        nameLabel.text = result.description
        addButton.isHidden = addedButtonIsHidden
    }
}
