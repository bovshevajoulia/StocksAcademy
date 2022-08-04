//
//  PersistentManager.swift
//  StocksAcademy
//
//  Created by bovsheva on 19.06.2022.
//

import Foundation


struct PersistentManager: PersistentManagerProtocol {
    
    // MARK: - Private
    
    /// Constants
    private struct Constants {
        static let watchListKey = "watchlist"
    }
    
    private func updateStoredSymbols(with value: [SymbolData]) {
        if let encoded = try? JSONEncoder().encode(value) {
            UserDefaults.standard.set(encoded, forKey: Constants.watchListKey)
        }
    }
    
    private func defaultSymbols() -> [SymbolData] {
        let dafaultData = [SymbolData(description: "Apple Inc.", symbol: "AAPL"),
                           SymbolData(description: "SoundHound AI, Inc.", symbol: "SOUN"),
                           SymbolData(description: "Microsoft corporation", symbol: "MSFT")
        ]
        
        self.updateStoredSymbols(with: dafaultData)
        
        return dafaultData.sorted { $0.symbol < $1.symbol }
    }
    
    // MARK: - Public
    
    /// This function checks the stored data with the key "watchlist",
    /// if it is empty adds default symbols to the "watchlist"
    /// - Returns: Array of 'SymbolData'
    public func storedSymbols() -> [SymbolData] {
        
        guard let saved = UserDefaults.standard.object(forKey: Constants.watchListKey) as? Data else {
            return defaultSymbols()
        }
        
        if let symbolList = try? JSONDecoder().decode([SymbolData].self, from: saved) {
            if symbolList.isEmpty == false {
                return symbolList.sorted { $0.symbol < $1.symbol }
            }
        }
        
        return defaultSymbols()
    }
    
    
    /// Removes the symbol from stored symbol list
    /// - Parameter symbol: Value of symbol to remove
    /// - Returns: New stored symbols array
    public func remove(symbol: String) -> [SymbolData] {
        let storedList = storedSymbols()
        var newList = [SymbolData]()
        
        storedList.forEach { storedSymbol in
            if storedSymbol.symbol != symbol {
                newList.append(storedSymbol)
            }
        }
        self.updateStoredSymbols(with: newList)
        
        return newList.sorted { $0.symbol < $1.symbol }
    }
    
    
    /// Adds the symbol to stored symbol list
    /// - Parameter symbol: Value of symbol to add
    /// - Returns: New stored symbols array
    public func add(symbol: SymbolData) -> [SymbolData] {
        var storedList = storedSymbols()
        
        if storedList.contains(where: { $0.symbol == symbol.symbol }) {
            return storedList.sorted { $0.symbol < $1.symbol }
        }
        
        storedList.append(symbol)
        self.updateStoredSymbols(with: storedList)
        
        return storedList.sorted { $0.symbol < $1.symbol }
    }
}
