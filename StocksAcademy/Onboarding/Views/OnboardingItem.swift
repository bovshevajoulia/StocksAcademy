//
//  OnboardingItem.swift
//  StocksAcademy
//
//  Created by bovsheva on 16.07.2022.
//

import Foundation

struct OnboardingItem: Identifiable {
    var id = UUID()
    
    let title: String
    let description: String
    let information: String
}

extension StocksAcademy {
    static let onboardingItems = [OnboardingItem(title: "Stock Market Investing for Beginners",
                                                 description: "Learn all the Basics of the Stock Market, through comprehensive, interesting and fun lectures!",
                                                 information: "Specializations"),
                                  OnboardingItem(title: "Join Stocks Real-time Market 'Finnhub Stock'",
                                                 description: "30 years of historical data for US market updated in real-time. 15-minute delayed LSE data and End-of-day tick-level data for international markets are available on Finnhub.",
                                                information: "Stocks Market"),
                                  
                                  OnboardingItem(title: "Understanding Financial Markets Courses",
                                                 description: "In this course, you will learn what the main financial markets and their characteristics are as well as how they are linked to the economy. ",
                                                 information: "Specializations"),
    ]
}
