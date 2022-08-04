//
//  NewsStory.swift
//  StocksAcademy
//
//  Created by bovsheva on 26.06.2022.
//

import Foundation

/// Represent news story
struct NewsStory: Codable, Identifiable {
    let category: String
    let datetime: TimeInterval
    let headline: String
    let id: TimeInterval
    let image: String
    let related: String
    let source: String
    let summary: String
    let url: String
    
}

extension NewsStory {
    
    static public func dummyNewsStory() -> NewsStory {
        return NewsStory(category: "company",
                         datetime: 1656172380,
                         headline: "2 Red Flags for Meta Platforms' Future",
                         id: 112655443,
                         image: "",
                         related: "AAPL",
                         source: "Yahoo",
                         summary: "Meta Platforms (NASDAQ: META) faces substantial headwinds that are hurting its prospects.  Consumers are once again changing the way they interact with social media apps.  The change is forcing Meta Platforms to adapt, which may or may not work out in the longer run.",
                         url: "https://finnhub.io/api/news?id=b19103f450c2cab45619c5b2f23293e68440b87c1d22f5d0e60da5f11350aa65")
    }
}
/*
 
 {
 "category":"company",
 "datetime":1656172380,
 "headline":"2 Red Flags for Meta Platforms' Future",
 "id":112655443,
 "image":"",
 "related":"AAPL",
 "source":"Yahoo",
 "summary":"Meta Platforms (NASDAQ: META) faces substantial headwinds that are hurting its prospects.  Consumers are once again changing the way they interact with social media apps.  The change is forcing Meta Platforms to adapt, which may or may not work out in the longer run.",
 "url":"https://finnhub.io/api/news?id=b19103f450c2cab45619c5b2f23293e68440b87c1d22f5d0e60da5f11350aa65"
 }

 */
