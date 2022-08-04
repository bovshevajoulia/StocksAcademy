//
//  StocksListViewModelTests.swift
//  StocksAcademyTests
//
//  Created by bovsheva on 31.07.2022.
//

import XCTest
@testable import StocksAcademy
import Combine

class StocksListViewModelTests: XCTestCase {
    
    let manager = StocksManagerMock()
    
    var subscribtions = Set<AnyCancellable>()
    
    override func setUp() {
        
        self.manager.setUpEmptyData()
        
        self.manager.stockSymbols = [
            SymbolData(description: "Apple Inc.", symbol: "AAPL"),
            SymbolData(description: "SoundHound AI, Inc.", symbol: "SOUN"),
            SymbolData(description: "Microsoft corporation", symbol: "MSFT")
        ]
        
        print("StocksListViewModelTests:Setup")
    }
    
    func test_getting_stocks_symbols_success() throws {
        
        let vm = StocksListViewModel(manager: self.manager)
        
        let promise = expectation(description: "getting symbols")
        
        vm.storedStockSymbols
            .sink { symbols in
                if symbols.count == 3 {
                    promise.fulfill()
                }
            }
            .store(in: &subscribtions)
        
        wait(for: [promise], timeout: 3)
    }
    
    func test_removing_stocks_symbols_success() throws {
        
        let vm = StocksListViewModel(manager: self.manager)
        
        let promise = expectation(description: "removing symbols")
        
        vm.deleteSymbol.send("AAPL")
        
        vm.storedStockSymbols
            .sink { symbols in
                if symbols.count == 2 {
                    promise.fulfill()
                }
            }
            .store(in: &subscribtions)
        
        wait(for: [promise], timeout: 3)
    }

    func test_adding_stocks_symbols_success() throws {
        
        let vm = StocksListViewModel(manager: self.manager)
        
        let promise = expectation(description: "adding symbols")
        
        vm.addSymbol.send(SymbolData(description: "Starbucks Corp.", symbol: "SBUX"))
        
        vm.storedStockSymbols
            .sink { symbols in
                if symbols.count == 4 {
                    promise.fulfill()
                }
            }
            .store(in: &subscribtions)
        
        wait(for: [promise], timeout: 3)
    }
    
}
