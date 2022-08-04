//
//  SpecializationCardItem.swift
//  StocksAcademy
//
//  Created by bovsheva on 17.07.2022.
//

import SwiftUI

extension StocksAcademy {
    
    struct SpecializationCardItem: Identifiable {
        let id = UUID()
        let image: Image
        let specialization: Specialization
    }
    
    static let images = [Image("hand-1"), Image("hand-2"), Image("interaction-1"), Image("bank-1"), Image("computer-work-1"), Image("computer-work-2"), Image("savings")]

    
    static func convert(from specialization: StocksAcademy.Specialization) -> StocksAcademy.SpecializationCardItem {
        SpecializationCardItem(image: StocksAcademy.images.randomElement() ?? Image("hand-1"),
                               specialization: specialization)
    }
    
    static let dummySpecializations =  [
        
        StocksAcademy.convert(from: StocksAcademy.portfolioManagement()),
        
        StocksAcademy.convert(from: StocksAcademy.financialMarkets())
    ]
}
