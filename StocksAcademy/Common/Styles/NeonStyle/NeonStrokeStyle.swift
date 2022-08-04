//
//  NeonStrokeStyle.swift
//  StocksAcademy
//
//  Created by bovsheva on 17.07.2022.
//

import SwiftUI

extension NeonStyle {
    
    struct GradientStrokeStyle: ViewModifier {
        
        var lineWidth: CGFloat
        
        var shape: ShapeType
        
        var colors = [
            NeonStyle.strokeGradient1,
            NeonStyle.strokeGradient2,
            NeonStyle.strokeGradient3,
            NeonStyle.strokeGradient4
        ]
        
        func body(content: Content) -> some View {
            content
                .modifier(StrokeBaseStyle(lineWidth: lineWidth,
                                          shape: self.shape,
                                          colors: self.colors,
                                          blurRadius: lineWidth * 10,
                                          blurLineWidth: lineWidth * 5)
                )
        }
    }
}
