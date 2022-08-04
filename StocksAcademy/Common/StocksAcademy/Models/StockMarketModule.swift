//
//  StockMarketModule.swift
//  StocksAcademy
//
//  Created by bovsheva on 07.07.2022.
//

import Foundation

extension StocksAcademy {
    
    struct Module {
        let title: String
        let description: String
        let estimatedTime: String
    }
    
    static public func getModules(for course: String) -> [Module] {
        
        switch course {
                
            case "Markets and Instruments":
                return globalFinancialMarketsInstrumentsModules()
                
            case "Portfolio and Risk Management":
                return portfolioSelectionRiskManagementModules()
            
            case "Financial Markets":
                return financialMarketsModules()
            
            case "Financial Accounting: Foundations":
                return financialAccountingModules()
            
            case "Applications for Investors":
                return financialApplicationsModules()
            
            case "Fundamentals of Performance Evaluation":
                return financialFundamentalsModules()
                
            default:
                return [Module]()
        }
    }
}
