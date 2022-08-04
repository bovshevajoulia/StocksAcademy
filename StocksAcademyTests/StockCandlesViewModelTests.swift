//
//  StockCandlesViewModelTests.swift
//  StocksAcademyTests
//
//  Created by bovsheva on 31.07.2022.
//

import XCTest
@testable import StocksAcademy
import Combine


class StockCandlesViewModelTests: XCTestCase {
    
    let manager = StocksManagerMock()
    
    var subscribtions = Set<AnyCancellable>()
    
    let symbolStockCandles = SymbolStockCandles.dummySymbolStockCandles()
    
    override func setUp() {
        
        self.manager.setUpEmptyData()
        
        self.manager.stockCandlesResult = Result.success(self.symbolStockCandles)
        
        print("StockCandlesViewModelTests:Setup")
    }
    
    func test_getting_stockcandles_success() throws {
        let vm = StockCandlesViewModel(manager: self.manager,
                                       stockSymbol: self.manager.dummySymbol())
        
        let promise = expectation(description: "getting stockcandles")
        
        vm.symbolStockCandles
            .sink(receiveCompletion: { completion in
                
            }, receiveValue: { symbolStockCandles in
                if symbolStockCandles.candles.count == self.symbolStockCandles.candles.count {
                    promise.fulfill()
                }
            })
            .store(in: &subscribtions)
        
        wait(for: [promise], timeout: 3)
    }
    
    func test_getting_stockcandles_error() throws {
        
        self.manager.stockCandlesResult = Result.failure(APIError.badResponse(statusCode: 404))
        
        let vm = StockCandlesViewModel(manager: self.manager,
                                       stockSymbol: self.manager.dummySymbol())
        
        let promise1 = expectation(description: "getting stockcandles")
        let promise2 = expectation(description: "getting error")
        
        vm.errorMessage
            .sink { error in
                if error.isEmpty == false {
                    promise2.fulfill()
                }
                else {
                    XCTFail()
                }
            }
            .store(in: &subscribtions)
        
        vm.symbolStockCandles
            .sink(receiveCompletion: { completion in
                
            }, receiveValue: { symbolStockCandles in
                if symbolStockCandles.candles.count == 0 {
                    promise1.fulfill()
                }
                else {
                    XCTFail()
                }
            })
            .store(in: &subscribtions)
        
        wait(for: [promise1, promise2], timeout: 3)
    }
}
