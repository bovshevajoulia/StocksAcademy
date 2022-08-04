//
//  Course.swift
//  StocksAcademy
//
//  Created by bovsheva on 06.07.2022.
//

import SwiftUI

extension StocksAcademy {
    
    struct Course: Identifiable {
        let id = UUID()
        let title: String
        let partner: String
        let skills: String
        let shortDescription: String
        let description: String
        let level: String
        let partnerImage: String
        let estimatedTime: String
    }
    
    static public func getCourses(for specialization: String) -> [Course] {
        
        switch specialization {
                
            case "Global Financial Markets and Instruments":
                return investmentPortfolioManagementCourses()
                
            case "Financial Markets":
                return financialMarketsCourses()
            
            case "Financial Managment":
                return financialManagmentCourses()
                
            default:
                return [Course]()
        }
    }
}


