//
//  StockMarketSpecialization.swift
//  StocksAcademy
//
//  Created by bovsheva on 08.07.2022.
//

import Foundation

extension StocksAcademy {
    
    struct Specialization {
        let title: String
        let partner: String
        let skills: String
        let shortDescription: String
        let description: String
        let level: String
        let partnerImage: String
        let estimatedTime: String
    }
    
    static public func getSpecializations() -> [StocksAcademy.Specialization] {
        return [StocksAcademy.portfolioManagement(),
                StocksAcademy.financialMarkets(),
                StocksAcademy.financialManagment()
        ]
    }
}
