//
//  Extension+Strideable.swift
//  StocksAcademy
//
//  Created by bovsheva on 30.07.2022.
//

import Foundation

/*
    let range: CountableClosedRange<Int> = 0...10
    15.clamped(to: range) // returns 10
 */

extension Strideable where Stride: SignedInteger {
    func clamped(to limits: CountableClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}

/*
 
    15.clamped(to: 0...10) // returns 10
    3.0.clamped(to: 0.0...10.0) // returns 3.0
    "a".clamped(to: "g"..."y") // returns "g"
 
 */
extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}
