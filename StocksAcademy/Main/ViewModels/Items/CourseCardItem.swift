//
//  CourseCardItem.swift
//  StocksAcademy
//
//  Created by bovsheva on 20.07.2022.
//

import Foundation
import SwiftUI

extension StocksAcademy {
    
    struct CourseCardItem: Identifiable {
        let id = UUID()
        let image: Image
        let background: LinearGradient
        let course: Course
    }
    
    static func convert(from course: StocksAcademy.Course) -> StocksAcademy.CourseCardItem {
        CourseCardItem(image: StocksAcademy.images.randomElement() ?? Image("hand-1"),
                       background: GlassStyle.gradients.randomElement() ?? LinearGradient(colors: [Color("glass-color-1"), Color("glass-color-3")], startPoint: .topLeading, endPoint: .bottomTrailing),
                       course: course)
    }
    
    /// Dummy data for UI
    static let dummyCourses =  [
        StocksAcademy.convert(from: StocksAcademy.globalFinancialMarketsInstrumentsCourse()),
        StocksAcademy.convert(from: StocksAcademy.financialMarketsCourse()),
        StocksAcademy.convert(from: StocksAcademy.portfolioSelectionRiskManagementCourse())
    ]
}
