//
//  FinancialMarkets.swift
//  StocksAcademy
//
//  Created by bovsheva on 08.07.2022.
//

import SwiftUI

extension StocksAcademy {
    
    /// Dummy specialization:  Financial Markets
    static public func financialMarkets() -> Specialization {
        
        return Specialization(title: "Financial Markets",
                              partner: "Yeal University",
                              skills: "Regulations and Compliance, Accounting, Business Process",
                              shortDescription: "This course is so useful to know about finance in depth it gives more examples about the finance . It help to make more decision in finance market. It also motivate students to attract towards finance.",
                              description: "An overview of the ideas, methods, and institutions that permit human society to manage risks and foster enterprise.  Emphasis on financially-savvy leadership skills. Description of practices today and analysis of prospects for the future. Introduction to risk management and behavioral finance principles to understand the real-world functioning of securities, insurance, and banking industries.  The ultimate goal of this course is using such industries effectively and towards a better society.",
                              
                              level: "Beginner-Specialization",
                              partnerImage: "yale-logo",
                              estimatedTime: "7 modules - 35 hours"
        )
    }
    
    /// Dummy Financial Markets courses
    static public func financialMarketsCourses() -> [Course] {
        let courses = [financialMarketsCourse()]
        return courses
    }
    
    static public func financialMarketsCourse() -> Course {
        
        return Course(title: "Financial Markets",
                      partner: "Yeal University",
                      skills: "Regulations and Compliance, Accounting, Business Process",
                      shortDescription: "This course is so useful to know about finance in depth it gives more examples about the finance . It help to make more decision in finance market. It also motivate students to attract towards finance.",
                      description: "An overview of the ideas, methods, and institutions that permit human society to manage risks and foster enterprise.  Emphasis on financially-savvy leadership skills. Description of practices today and analysis of prospects for the future. Introduction to risk management and behavioral finance principles to understand the real-world functioning of securities, insurance, and banking industries.  The ultimate goal of this course is using such industries effectively and towards a better society.",
                      
                      level: "Beginner-Course",
                      partnerImage: "yale-logo",
                      estimatedTime: "7 modules - 35 hours"
                      
        )
    }
    
    static public func financialMarketsModules() -> [Module] {
        let modules = [financialFirstModule(),
                       financialSecondModule(),
                       financialThirdModule(),
                       financialFourthModule(),
                       financialFifthModule(),
                       financialSixthModule()]
        return modules
    }
    
    
    static public func financialFirstModule() -> Module {
        return Module(title: "Financial Markets Introduction",
                      description: "Welcome to the course! In this opening module, you will learn the basics of financial markets, insurance, and CAPM (Capital Asset Pricing Model). This module serves as the foundation of this course.",
                      estimatedTime: "6 hours"
                      
        )
    }
    
    static public func financialSecondModule() -> Module {
        return Module(title: "Real Estate: Risk Management Devices",
                      description: "In this next module, dive into some details of behavioral finance, forecasting, pricing, debt, and inflation.",
                      estimatedTime: "4 hours"
                      
        )
    }
    
    static public func financialThirdModule() -> Module {
        return Module(title: "Federal Funds and Interest Rates",
                      description: "Stocks, bonds, dividends, shares, market caps; what are these? Who needs them? Why? Module 3 explores these concepts, along with corporation basics and some basic financial markets history.",
                      estimatedTime: "4 hours"
                      
        )
    }
    
    static public func financialFourthModule() -> Module {
        return Module(title: "History of Mortgage Lending",
                      description: "Take a look into the recent past, exploring recessions, bubbles, the mortgage crisis, and regulation.",
                      estimatedTime: "7 hours"
                      
        )
    }
    
    static public func financialFifthModule() -> Module {
        return Module(title: "Forwards and Futures Introduction",
                      description: "Options and bond markets are explored in module 5, important components of financial markets.",
                      estimatedTime: "4 hours"
                      
        )
    }
    
    static public func financialSixthModule() -> Module {
        return Module(title: "Investment Banks Introduction",
                      description: "In module 6, Professor Shiller introduces investment banking, underwriting processes, brokers, dealers, exchanges, and new innovations in financial markets.",
                      estimatedTime: "4 hours"
                      
        )
    }
}
