//
//  FinancialManagment.swift
//  StocksAcademy
//
//  Created by bovsheva on 29.07.2022.
//

import Foundation

extension StocksAcademy {
    
    ///Dummy specialization:  Financial Managment
    static public func financialManagment() -> Specialization {
        
        return Specialization(title: "Financial Managment",
                              partner: "University of Illinois",
                              skills: "Accounting, Business Process, Financial Statement, Investment, Risk Management",
                              shortDescription: "When you complete the Financial Management Specialization, you will: Have a solid foundation in developing an integrated framework for strategic financial decision-making.",
                              description: "This Specialization covers the fundamentals of strategic financial management, including financial accounting, investments, and corporate finance. You will learn to evaluate major strategic corporate and investment decisions and to understand capital markets and institutions from a financial perspective, and you will develop an integrated framework for value-based financial management and individual financial decision-making.",
                              
                              level: "Beginner-Specialization",
                              partnerImage: "yale-logo",
                              estimatedTime: "7 modules - 35 hours"
        )
    }
    
    ///Dummy Financial Managment courses
    static public func financialManagmentCourses() -> [Course] {
        let courses = [financialAccountingCourse(),
                       financialFundamentalsCourse(),
                       financialApplicationsCourse()
        ]
        return courses
    }
    
    static public func financialAccountingCourse() -> Course {
        
        return Course(title: "Financial Accounting: Foundations",
                      partner: "University of Illinois",
                      skills: "Regulations and Compliance, Accounting, Business Process",
                      shortDescription: "Understand main financial statements and the financial information they provide: Write a financial transaction in financial accounting language and understand how this impacts main financial statements",
                      description: "In this course, you will learn foundations of financial accounting information. You will start your journey with a general overview of what financial accounting information is and the main financial statements. You will then learn how to code financial transactions in financial accounting language. In the meantime, you will learn about the most important concept in contemporary financial accounting: accrual accounting. You will then critically analyze how firms recognize revenues. Finally, you will finish the course with an analysis of accounting for short-term assets where you will go into detail on how firms account for accounts receivables and inventories.",
                      
                      level: "Beginner-Course",
                      partnerImage: "yale-logo",
                      estimatedTime: "7 modules - 35 hours"
                      
        )
    }
    
    static public func financialAccountingModules() -> [Module] {
        let modules = [financialAccountingFirstModule(),
                       financialAccountingSecondModule(),
                       financialAccountingThirdModule(),
                       financialAccountingFourthModule(),
                       financialAccountingFifthModule(),
                       financialAccountingSixthModule()]
        return modules
    }
    
    
    static public func financialAccountingFirstModule() -> Module {
        return Module(title: "Financial Markets Introduction",
                      description: "Welcome to the course! In this opening module, you will learn the basics of financial markets, insurance, and CAPM (Capital Asset Pricing Model). This module serves as the foundation of this course.",
                      estimatedTime: "6 hours"
                      
        )
    }
    
    static public func financialAccountingSecondModule() -> Module {
        return Module(title: "Real Estate: Risk Management Devices",
                      description: "In this next module, dive into some details of behavioral finance, forecasting, pricing, debt, and inflation.",
                      estimatedTime: "4 hours"
                      
        )
    }
    
    static public func financialAccountingThirdModule() -> Module {
        return Module(title: "Federal Funds and Interest Rates",
                      description: "Stocks, bonds, dividends, shares, market caps; what are these? Who needs them? Why? Module 3 explores these concepts, along with corporation basics and some basic financial markets history.",
                      estimatedTime: "4 hours"
                      
        )
    }
    
    static public func financialAccountingFourthModule() -> Module {
        return Module(title: "History of Mortgage Lending",
                      description: "Take a look into the recent past, exploring recessions, bubbles, the mortgage crisis, and regulation.",
                      estimatedTime: "7 hours"
                      
        )
    }
    
    static public func financialAccountingFifthModule() -> Module {
        return Module(title: "Forwards and Futures Introduction",
                      description: "Options and bond markets are explored in module 5, important components of financial markets.",
                      estimatedTime: "4 hours"
                      
        )
    }
    
    static public func financialAccountingSixthModule() -> Module {
        return Module(title: "Investment Banks Introduction",
                      description: "In module 6, Professor Shiller introduces investment banking, underwriting processes, brokers, dealers, exchanges, and new innovations in financial markets.",
                      estimatedTime: "4 hours"
                      
        )
    }
    
    static public func financialFundamentalsCourse() -> Course {
        
        return Course(title: "Fundamentals of Performance Evaluation",
                      partner: "University of Illinois",
                      skills: "Regulations and Compliance, Accounting, Business Process",
                      shortDescription: "In this course, we will discuss fundamental principles of trading off risk and return, portfolio optimization, and security pricing.",
                      description: "In this course, we will discuss fundamental principles of trading off risk and return, portfolio optimization, and security pricing. We will study and use risk-return models such as the Capital Asset Pricing Model (CAPM) and multi-factor models to evaluate the performance of various securities and portfolios. Specifically, we will learn how to interpret and estimate regressions that provide us with both a benchmark to use for a security given its risk (determined by its beta), as well as a risk-adjusted measure of the security’s performance (measured by its alpha). Building upon this framework, market efficiency and its implications for patterns in stock returns and the asset-management industry will be discussed. Finally, the course will conclude by connecting investment finance with corporate finance by examining firm valuation techniques such as the use of market multiples and discounted cash flow analysis. The course emphasizes real-world examples and applications in Excel throughout. This course is the first of two on Investments that I am offering online (“Investments II: Lessons and Applications for Investors” is the second course).",
                      
                      level: "Beginner-Course",
                      partnerImage: "yale-logo",
                      estimatedTime: "7 modules - 35 hours"
                      
        )
    }
    
    static public func financialFundamentalsModules() -> [Module] {
        let modules = [financialFundamentalsFirstModule(),
                       financialFundamentalsSecondModule(),
                       financialFundamentalsThirdModule()
        ]
        return modules
    }
    
    
    static public func financialFundamentalsFirstModule() -> Module {
        return Module(title: "Financial Markets Introduction",
                      description: "Welcome to the course! In this opening module, you will learn the basics of financial markets, insurance, and CAPM (Capital Asset Pricing Model). This module serves as the foundation of this course.",
                      estimatedTime: "6 hours"
                      
        )
    }
    
    static public func financialFundamentalsSecondModule() -> Module {
        return Module(title: "Real Estate: Risk Management Devices",
                      description: "In this next module, dive into some details of behavioral finance, forecasting, pricing, debt, and inflation.",
                      estimatedTime: "4 hours"
                      
        )
    }
    
    static public func financialFundamentalsThirdModule() -> Module {
        return Module(title: "Federal Funds and Interest Rates",
                      description: "Stocks, bonds, dividends, shares, market caps; what are these? Who needs them? Why? Module 3 explores these concepts, along with corporation basics and some basic financial markets history.",
                      estimatedTime: "4 hours"
                      
        )
    }
    
    
    static public func financialApplicationsCourse() -> Course {
        
        return Course(title: "Applications for Investors",
                      partner: "University of Illinois",
                      skills: "Regulations and Compliance, Accounting, Business Process",
                      shortDescription: "In this course, you will start by reviewing the fundamentals of investments, including the trading off of return and risk when forming a portfolio, asset pricing models such as the Capital Asset Pricing Model (CAPM) and the 3-Factor Model, and the efficient market hypothesis.",
                      description: "You will be introduced to the two components of stock returns – dividends and capital gains – and will learn how each are taxed and the incentives provided to investors from a realization-based capital gains tax.  You will examine the investment decisions (and behavioral biases) of participants in defined-contribution (DC) pension plans like 401(k) plans in the U.S. and will learn about the evidence regarding the performance of individual investors in their stock portfolios.  The course concludes by discussing the evidence regarding the performance of actively-managed mutual funds. You will learn about the fees charged to investors by mutual funds and the evidence regarding the relation between fees charged and fund performance.  Segments of the portfolios of mutual funds that may be more likely to outperform and examples of strategies designed to “earn alpha” will also be introduced.",
                      
                      level: "Beginner-Course",
                      partnerImage: "yale-logo",
                      estimatedTime: "7 modules - 35 hours"
                      
        )
    }
    
    static public func financialApplicationsModules() -> [Module] {
        let modules = [financialApplicationsFirstModule(),
                       financialApplicationsSecondModule(),
                       financialApplicationsThirdModule()
        ]
        return modules
    }
    
    
    static public func financialApplicationsFirstModule() -> Module {
        return Module(title: "Financial Markets Introduction",
                      description: "Welcome to the course! In this opening module, you will learn the basics of financial markets, insurance, and CAPM (Capital Asset Pricing Model). This module serves as the foundation of this course.",
                      estimatedTime: "6 hours"
                      
        )
    }
    
    static public func financialApplicationsSecondModule() -> Module {
        return Module(title: "Real Estate: Risk Management Devices",
                      description: "In this next module, dive into some details of behavioral finance, forecasting, pricing, debt, and inflation.",
                      estimatedTime: "4 hours"
                      
        )
    }
    
    static public func financialApplicationsThirdModule() -> Module {
        return Module(title: "Federal Funds and Interest Rates",
                      description: "Stocks, bonds, dividends, shares, market caps; what are these? Who needs them? Why? Module 3 explores these concepts, along with corporation basics and some basic financial markets history.",
                      estimatedTime: "4 hours"
                      
        )
    }

}
