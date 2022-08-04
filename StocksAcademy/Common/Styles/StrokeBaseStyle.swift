//
//  StrokeBaseStyle.swift
//  StocksAcademy
//
//  Created by bovsheva on 17.07.2022.
//

import SwiftUI

struct StrokeBaseStyle: ViewModifier {
    
    var lineWidth: CGFloat
    
    var shape: ShapeType
    
    var colors: [Color]
    
    var blurRadius: CGFloat
    
    var blurLineWidth: CGFloat
    
    @ViewBuilder
    func clipToRectangle(content: Content, cornerRadius: CGFloat) -> some View {
        content
            .overlay {
                RoundedRectangle(cornerRadius: cornerRadius,
                                 style: RoundedCornerStyle.continuous)
                    .stroke(
                        .linearGradient(colors: self.colors,
                                        startPoint: UnitPoint.topLeading,
                                        endPoint: UnitPoint.bottomTrailing),
                        lineWidth: lineWidth
                    )
                    .overlay {
                        RoundedRectangle(cornerRadius: cornerRadius,
                                         style: RoundedCornerStyle.continuous)
                            .stroke(
                                .linearGradient(colors: self.colors,
                                                startPoint: UnitPoint.topLeading,
                                                endPoint: UnitPoint.bottomTrailing),
                                lineWidth: blurLineWidth
                            )
                            .blur(radius: blurRadius)
                    }
            }
    }
    
    @ViewBuilder
    func clipToCircle(content: Content) -> some View {
        content
            .overlay {
                Circle()
                    .stroke(
                        .linearGradient(colors: self.colors,
                                        startPoint: UnitPoint.topLeading,
                                        endPoint: UnitPoint.bottomTrailing),
                        lineWidth: lineWidth
                    )
                    .overlay {
                        Circle()
                            .stroke(
                                .linearGradient(colors: self.colors,
                                                startPoint: UnitPoint.topLeading,
                                                endPoint: UnitPoint.bottomTrailing),
                                lineWidth: blurLineWidth
                            )
                            .blur(radius: blurRadius)
                    }
            }
    }
    
    @ViewBuilder
    func clipToCapsule(content: Content) -> some View {
        content
            .overlay {
                Capsule()
                    .stroke(
                        .linearGradient(colors: self.colors,
                                        startPoint: UnitPoint.topLeading,
                                        endPoint: UnitPoint.bottomTrailing),
                        lineWidth: lineWidth
                    )
                    .overlay {
                        Capsule()
                            .stroke(
                                .linearGradient(colors: self.colors,
                                                startPoint: UnitPoint.topLeading,
                                                endPoint: UnitPoint.bottomTrailing),
                                lineWidth: blurLineWidth
                            )
                            .blur(radius: blurRadius)
                    }
            }
    }
    
    func body(content: Content) -> some View {
        
        switch self.shape {
                
            case .oval:
                
                self.clipToCapsule(content: content)
                
            case .rectangle(let cornerRadius):
                
                self.clipToRectangle(content: content, cornerRadius: cornerRadius)
                
            case .circle:
                
                self.clipToCircle(content: content)
        }
    }
}

