//
//  ScrollDetection.swift
//  StocksAcademy
//
//  Created by bovsheva on 19.07.2022.
//

import Foundation
import SwiftUI

struct ScrollDetection: ViewModifier {
    
    @Binding var hasScrolled: Bool
    var namespace: String
    
    struct ScrollPreferenceKey: PreferenceKey {
        typealias Value = CGFloat
        static var defaultValue = CGFloat.zero
        static func reduce(value: inout Value, nextValue: () -> Value) {
            value += nextValue()
        }
    }
    
    func body(content: Content) -> some View {
        content
            .background(GeometryReader { proxy in
                Color.clear.preference(key: ScrollPreferenceKey.self,
                                       value: proxy.frame(in: .named(namespace)).minY)
            })
            .onPreferenceChange(ScrollPreferenceKey.self, perform: { value in
                withAnimation(.easeInOut) {
                    if value < 0 {
                        hasScrolled = true
                    } else {
                        hasScrolled = false
                    }
                }
            })
    }
}

extension View {
    
    func detectScrolling(in namespace: String, hasScrolled: Binding<Bool>)  -> some View {
        modifier(ScrollDetection(hasScrolled: hasScrolled, namespace: namespace))
    }
}
