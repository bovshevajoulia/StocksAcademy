//
//  PersistentServiceProtocol.swift
//  StocksAcademy
//
//  Created by bovsheva on 21.06.2022.
//

import Foundation

protocol PersistentManagerProtocol {
    
    func storedSymbols() -> [SymbolData]
    
    func remove(symbol: String) -> [SymbolData]
    
    func add(symbol: SymbolData) -> [SymbolData]
}
