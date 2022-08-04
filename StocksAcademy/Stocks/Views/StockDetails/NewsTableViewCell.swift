//
//  NewsTableViewCell.swift
//  DreamBank
//
//  Created by bovsheva on 13.07.2022.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    static let identifier = "NewsTableViewCell"
    static let prefferedHeight: CGFloat = 200
    
    // Source label
    private let sourceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .left
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Headline label
    private let headlineLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.numberOfLines = 3
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Summury label
    private let summaryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 5
        label.textAlignment = .left
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Date label
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // MARK: init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = nil
        backgroundColor = nil
        addSubviews(sourceLabel, headlineLabel, summaryLabel, dateLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            sourceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            sourceLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            headlineLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            headlineLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            headlineLabel.topAnchor.constraint(equalTo: sourceLabel.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            summaryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            summaryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            summaryLabel.topAnchor.constraint(equalTo: headlineLabel.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            dateLabel.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: 10)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        sourceLabel.text = nil
        headlineLabel.text = nil
        summaryLabel.text = nil
        dateLabel.text = nil
    }
    
    public func configure(with story: NewsStory) {
        sourceLabel.text = story.source
        headlineLabel.text = story.headline
        summaryLabel.text = story.summary
        dateLabel.text = .string(from: story.datetime)
    }
}
