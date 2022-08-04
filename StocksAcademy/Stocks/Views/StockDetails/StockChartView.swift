//
//  StockChartView.swift
//  DreamBank
//
//  Created by bovsheva on 20.06.2022.
//

import UIKit
import Charts
import SwiftUI
import Combine

class StockChartView: UIView {
    
    /// Chart View
    private let chartView: LineChartView = {
        let chartView = LineChartView()
        chartView.pinchZoomEnabled = false
        chartView.setScaleEnabled(true)
        chartView.xAxis.enabled = false
        chartView.drawGridBackgroundEnabled = false
        chartView.legend.enabled = false
        chartView.leftAxis.enabled = false
        chartView.rightAxis.enabled = false
        return chartView
    }()
    
    private var color = UIColor.red
    
    private var candlesViewModel: StockCandlesViewModel?
    private var subscribtions = Set<AnyCancellable>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(chartView)
        
        self.setupViewModelSubscriptions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        chartView.frame = bounds
    }
    
    private func setupViewModelSubscriptions() {
        
        self.candlesViewModel?.symbolStockCandles
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [unowned self] symbolStockCandles in
                if symbolStockCandles.candles.isEmpty == false {
                    self.reload(with: symbolStockCandles.candles)
                }
            })
            .store(in: &subscribtions)
        
        self.candlesViewModel?.errorMessage
            .receive(on: RunLoop.main)
            .removeDuplicates()
            .sink { [unowned self] error in
                if error.isEmpty == false {
                    self.reset()
                }
            }
            .store(in: &subscribtions)
    }
    
    func reset() {
        chartView.data = nil
    }
    
    private func reload(with candles: [CandleStick]) {
        var entries = [ChartDataEntry]()
        
        let closePrices = candles.map { $0.close }
        
        for (index, value) in closePrices.reversed().enumerated() {
            entries.append(
                .init(
                    x: Double(index),
                    y: value
                )
            )
        }
        
        chartView.rightAxis.enabled = true
        chartView.legend.enabled = true
        
        let dataSet = LineChartDataSet(entries: entries, label: "7 Days")
        dataSet.fillColor = self.color
        dataSet.drawFilledEnabled = true
        dataSet.drawIconsEnabled = false
        dataSet.drawValuesEnabled = false
        dataSet.drawCirclesEnabled = false
        let data = LineChartData(dataSet: dataSet)
        chartView.data = data
    }
    
    /// Configure View
    /// - Parameter viewModel: View ViewModel
    func configure(with candlesViewModel: StockCandlesViewModel, chartColor: UIColor) {
        self.candlesViewModel = candlesViewModel
        self.color = chartColor
        self.setupViewModelSubscriptions()
    }
}
