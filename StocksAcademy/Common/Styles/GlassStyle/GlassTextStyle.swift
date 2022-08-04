//
//  GlassTextStyle.swift
//  StocksAcademy
//
//  Created by bovsheva on 16.07.2022.
//

import SwiftUI

extension GlassStyle {
    
    struct TextColorStyle: ViewModifier {
        
        @Environment(\.colorScheme) var colorScheme
        
        func body(content: Content) -> some View {
            content
                .foregroundColor(colorScheme == .dark ? Color.white.opacity(0.7) : Color.black.opacity(0.5))
        }
    }
    
    struct TextPrimaryColorStyle: ViewModifier {
        
        func body(content: Content) -> some View {
            content
                .foregroundColor(Color.black.opacity(0.85))
        }
    }
    
    struct TextSecondaryColorStyle: ViewModifier {
        
        func body(content: Content) -> some View {
            content
                .foregroundColor(Color.black.opacity(0.65))
        }
    }
}
