//
//  PortfolioManagement.swift.swift
//  StocksAcademy
//
//  Created by bovsheva on 08.07.2022.
//

import SwiftUI

extension StocksAcademy {
    
    
    ///Dummy specialization:  Investment and Portfolio Management
    static public func portfolioManagement() -> Specialization {
        
        return Specialization(title: "Global Financial Markets and Instruments",
                      partner: "Rice University",
                      skills: "Performance Attribution, Behavioral Finance, Financial Markets, Portfolio Construction, Risk Management, Risk Analysis, Portfolio Optimization",
                      shortDescription: "In this four-course Specialization, you’ll learn the essential skills of portfolio management and personal investing.All investors – from the largest wealth funds to the smallest individual investors – share common issues in investing: how to meet their liabilities, how to decide where to invest, and how much risk to take on.",
                      description: "In this Specialization, you will learn how to think about, discuss, and formulate solutions to these investment questions. You will learn the theory and the real-world skills necessary to design, execute, and evaluate investment proposals that meet financial objectives. You will begin with an overview of global financial markets and instruments that characterize the investment opportunities available to today’s investor. You will then learn how to construct optimal portfolios that manage risk effectively, and how to capitalize on understanding behavioral biases and irrational behavior in financial markets. You will learn the best practices in portfolio management and performance evaluation as well as current investment strategies. By the end of your Capstone Project, you will have mastered the analytical tools, quantitative skills, and practical knowledge necessary for long-term investment management success.",

                      level: "Beginner-Specialization",
                      partnerImage: "rice-logo",
                      estimatedTime: "4 courses - 7 weeks"
                      
        )
    }
    
    ///Dummy Investment and Portfolio Management courses
    static public func investmentPortfolioManagementCourses() -> [Course] {
        let courses = [globalFinancialMarketsInstrumentsCourse(),
                       portfolioSelectionRiskManagementCourse()]
        return courses
    }
    
    // Global Financial Markets and Instruments
    static public func globalFinancialMarketsInstrumentsCourse() -> Course {
        
        return Course(title: "Markets and Instruments",
                      partner: "Rice University",
                      skills: "Performance Attribution, Behavioral Finance, Financial Markets, Portfolio Construction, Risk Management, Risk Analysis, Portfolio Optimization",
                      shortDescription: "This course is designed to be accessible for students of all knowledge levels and gives you the actionable foundation needed to manage money in a post-crisis world.",
                      description: "Get a running start in the high-stakes world of financial investment! This first course is designed to help you become an informed investor by providing you with the essential concepts for long-term success in managing money. You’ll start by learning the role of financial markets and financial assets in a well-functioning economy. From there, you’ll learn about the wide range of financial instruments available in major asset classes, their features and valuations. You’ll explore how financial markets actually operate in the real world, focusing on how and where securities are traded and how various market types differ from one another in practice. You will also learn the basics of algorithmic trading, dark pools, buying on margin and short selling. ",

                      level: "Beginner-Specialization",
                      partnerImage: "rice-logo",
                      estimatedTime: "7 modules - 35 hours"
                      
        )
    }
    
    static public func globalFinancialMarketsInstrumentsModules() -> [Module] {
        let modules = [investmentFirstModule(),
              investmentSecondModule(),
              investmentThirdModule(),
              investmentFourthModule()]
        return modules
    }
    
    static public func investmentFirstModule() -> Module {
        return Module(title: "Introduction & Review of Elementary Finance Tools",
                      description: "This module introduces the Investment and Portfolio Management Specialization, which is made up of four courses. This module discusses how the first course, Global Financial Markets and Assets, is organized. It outlines the different stages of the investment management process, which guides the focus of the Specialization. It also reviews basic finance concepts and tools such as time value of money, computing returns, discounting and compounding.",
                      estimatedTime: "1 week"
                      
        )
    }
    
    static public func investmentSecondModule() -> Module {
        return Module(title: "Financial system & financial assets: fixed income securities",
                      description: "In this and the next two modules, we cover the key institutional features of financial markets and instruments. We ask the following questions: Why do financial markets exist? What role do they play? What are financial assets and how are they different than real assets? How does it all come together? Basically, this is where I hope you will get to see the big picture of the entire financial system and how it comes together. Module 2 focuses on fixed income securities. We'll get started with a review of basics of bond valuation. You will learn about short-term money market instruments, U.S. Treasury securities as well as corporate bonds. After module 2, you will be able to describe fixed income securities, be familiar with their institutional features, and identify their cash flows. Finally, you will learn how to value fixed income securities such as Treasury bills, zero-coupon or coupon-bonds and compute yields.",
                      estimatedTime: "1 week"
                      
        )
    }
    
    static public func investmentThirdModule() -> Module {
        return Module(title: "Financial system & financial assets: equity securities and derivatives",
                      description: "In Module 3, we continue our overview of financial markets and instruments. We next focus on two other major asset classes: equity securities and derivative instruments. You will learn about how equity differs from fixed income securities, the cash flows associated with stock and preferred stock and how to find the value of a share. You will also learn about option strategies. After completing module 3, you will be able to describe all major asset classes, including derivative instruments such as options, forwards and futures. You will be able to explain how these differ from each other and their payoffs.",
                      estimatedTime: "1 week"
                      
        )
    }
    
    static public func investmentFourthModule() -> Module {
        return Module(title: "Organization of financial markets and securities trading",
                      description: "In this module, we discuss how financial markets actually work. We will talk about different trading venues and the mechanics of securities trading. I will emphasize a lot of terminology and the latest trends in securities trading to familiarize you with the institutional workings of financial markets. After this module, you will be able to compare different trading venues, trading mechanisms, and be able to explain different types of orders, including transactions like margin buying and short- selling; you will be familiar with the language and terminology you need in order to become an informed practitioner of investments.",
                      estimatedTime: "1 week"
                      
        )
    }
    
    // Portfolio Selection and Risk Management
    static public func portfolioSelectionRiskManagementCourse() -> Course {
        
        return Course(title: "Portfolio and Risk Management",
                      partner: "Rice University",
                      skills: "Performance Attribution, Behavioral Finance, Financial Markets, Portfolio Construction, Risk Management, Risk Analysis, Portfolio Optimization",
                      shortDescription: "You will next analyze how a portfolio choice problem can be structured and learn how to solve for and implement the optimal portfolio solution.",
                      description: "When an investor is faced with a portfolio choice problem, the number of possible assets and the various combinations and proportions in which each can be held can seem overwhelming. In this course, you’ll learn the basic principles underlying optimal portfolio construction, diversification, and risk management. You’ll start by acquiring the tools to characterize an investor’s risk and return trade-off. You will next analyze how a portfolio choice problem can be structured and learn how to solve for and implement the optimal portfolio solution. Finally, you will learn about the main pricing models for equilibrium asset prices.",

                      level: "Beginner-Specialization",
                      partnerImage: "rice-logo",
                      estimatedTime: "1 week"
        )
    }
    
    static public func portfolioSelectionRiskManagementModules() -> [Module] {
        let modules = [portfolioFirstModule(), portfolioSecondModule()]
        return modules
    }
    
    static public func portfolioFirstModule() -> Module {
        return Module(title: "Portfolio Selection and Risk Management",
                      description: "Develop risk and return measures for portfolio of assets. Understand the main insights from modern portfolio theory based on diversification. Describe and identify efficient portfolios that manage risk effectively. Solve for portfolio with the best risk-return trade-offs. Understand how risk preference drive optimal asset allocation decisions. Describe and use equilibrium asset pricing models.",
                      estimatedTime: "1 week"
                      
        )
    }
    
    static public func portfolioSecondModule() -> Module {
        return Module(title: "Biases and Portfolio Selection",
                      description: "Investors tend to be their own worst enemies. In this third course, you will learn how to capitalize on understanding behavioral biases and irrational behavior in financial markets. You will start by learning about the various behavioral biases – mistakes that investors make and understand their reasons. You will learn how to recognize your own mistakes as well as others’ and understand how these mistakes can affect investment decisions and financial markets.  You will also explore how different preferences and investment horizons impact the optimal asset allocation choice.",
                      estimatedTime: "1 week"
                      
        )
    }
    
}
