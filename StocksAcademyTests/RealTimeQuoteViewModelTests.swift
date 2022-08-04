//
//  RealTimeQuoteViewModelTests.swift
//  StocksAcademyTests
//
//  Created by bovsheva on 31.07.2022.
//

import XCTest
@testable import StocksAcademy
import Combine

class RealTimeQuoteViewModelTests: XCTestCase {
    
    let manager = StocksManagerMock()
    
    var subscribtions = Set<AnyCancellable>()
    
    override func setUp() {
        
        self.manager.setUpEmptyData()
        
        self.manager.stockRealTimeQuoteResult = Result.success(RealTimeQuote(
            currentPrice: 100.0,
            change: 15.0,
            percentChange: 2.0,
            highPrice: 150.0,
            lowPrice: 100.0,
            openPrice: 110.0,
            previousClosePrice: 120.0))
        
        print("RealTimeQuoteViewModelTests:Setup")
    }
    
    func test_getting_realtimequote_success() throws {
        let vm = RealTimeQuoteViewModel(manager: self.manager,
                                        symbol: self.manager.dummySymbol())
        
        let promise = expectation(description: "getting realtimequote")
        
        vm.stockRealTimeQuote
            .sink { quote in
            if quote.currentPrice == 100.0 {
                    promise.fulfill()
                }
            }
            .store(in: &subscribtions)
        
        wait(for: [promise], timeout: 3)
    }
    
    func test_realtime_refreshhing_start_success() throws {
        
        let vm = RealTimeQuoteViewModel(manager: self.manager,
                                        symbol: self.manager.dummySymbol(),
                                        timeInterval: 0.5)
        
        vm.activateRealTimeRefreshing.send(true)
        
        let promise = expectation(description: "realtime refreshhing start")
        
        self.manager.stockRealTimeQuoteResult = Result.success(RealTimeQuote(
            currentPrice: 40.0,
            change: 15.0,
            percentChange: 2.0,
            highPrice: 50.0,
            lowPrice: 20.0,
            openPrice: 25.0,
            previousClosePrice: 22.0))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [unowned self] in
            
            vm.stockRealTimeQuote
                .sink { quote in
                if quote.currentPrice == 40.0 {
                        promise.fulfill()
                    }
                }
                .store(in: &self.subscribtions)
        }
        
        wait(for: [promise], timeout: 5)
    }

    
    func test_realtime_refreshhing_stop_success() throws {
        
        let vm = RealTimeQuoteViewModel(manager: self.manager,
                                        symbol: self.manager.dummySymbol(),
                                        timeInterval: 0.5)
        
        vm.activateRealTimeRefreshing.send(true)
        
        let promise = expectation(description: "realtime refreshhing stop")
        
        self.manager.stockRealTimeQuoteResult = Result.success(RealTimeQuote(
            currentPrice: 40.0,
            change: 15.0,
            percentChange: 2.0,
            highPrice: 50.0,
            lowPrice: 20.0,
            openPrice: 25.0,
            previousClosePrice: 22.0))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [unowned self] in
            
            vm.activateRealTimeRefreshing.send(false)
            
            self.manager.stockRealTimeQuoteResult = Result.success(RealTimeQuote(
                currentPrice: 300.0,
                change: 5.0,
                percentChange: 12.0,
                highPrice: 300.0,
                lowPrice: 200.0,
                openPrice: 250.0,
                previousClosePrice: 220.0))
            
            vm.stockRealTimeQuote
                .sink { quote in
                if quote.currentPrice == 40.0 {
                        promise.fulfill()
                    }
                }
                .store(in: &self.subscribtions)
        }
        
        wait(for: [promise], timeout: 5)
    }
}
