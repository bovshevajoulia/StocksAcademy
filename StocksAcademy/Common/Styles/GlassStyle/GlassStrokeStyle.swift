//
//  GlassStrokeStyle.swift
//  StocksAcademy
//
//  Created by bovsheva on 15.07.2022.
//

import SwiftUI


extension GlassStyle {
    
    struct StrokeStyle: ViewModifier {
        
        @Environment(\.colorScheme) var colorScheme
        
        var shape: ShapeType
        var lineWidth: CGFloat = 1
        
        var colors: [Color]
        
        var defaultColors: [Color] {
            [Color.white.opacity(colorScheme == .dark ? 0.5 : 0.8),
             Color.black.opacity(colorScheme == .dark ? 0.6 : 0.3)]
        }
        
        init(shape: ShapeType, lineWidth: CGFloat = 1, colors: [Color] = []) {
            self.shape = shape
            self.lineWidth = lineWidth
            self.colors  = colors
        }
        
        func body(content: Content) -> some View {
            content
                .modifier(StrokeBaseStyle(lineWidth: lineWidth,
                                          shape: self.shape,
                                          colors: self.colors.isEmpty ? self.defaultColors : self.colors,
                                          blurRadius: 15,
                                          blurLineWidth: lineWidth * 2)
                )
        }
    }

    struct LightStrokeStyle: ViewModifier {
        
        var shape: ShapeType
        var lineWidth: CGFloat = 1
        
        var colors: [Color]
        
        func body(content: Content) -> some View {
            content
                .modifier(StrokeBaseStyle(lineWidth: lineWidth,
                                          shape: self.shape,
                                          colors: self.colors,
                                          blurRadius: 15,
                                          blurLineWidth: lineWidth * 2)
                )
        }
    }
}
