//
//  NeonModalBackgroundStyleGuide.swift
//  StocksAcademy
//
//  Created by bovsheva on 28.07.2022.
//

import SwiftUI

struct NeonModalBackgroundStyleGuide: View {
    
    var body: some View {
        
        VStack {
            Text("Neon ModalBackground style")
        }
        .frame(width: 300, height: 400)
        .modifier(NeonStyle.ModalBackgroundStyle())
    }
}

extension NeonStyle {
    
    struct ModalBackgroundStyle: ViewModifier {
        
        var cornerRadius: CGFloat = 20
        
        var lineWidth: CGFloat = 2
        
        func body(content: Content) -> some View {
            
            content
                .background(
                    .ultraThinMaterial
                )
                .mask {
                    RoundedRectangle(cornerRadius: cornerRadius,
                                     style: .continuous)
                }
                .modifier( NeonStyle.GradientStrokeStyle(lineWidth: lineWidth, shape: ShapeType.rectangle(cornerRadius: self.cornerRadius), colors: [
                    NeonStyle.strokeGradient5,
                    NeonStyle.strokeGradient5.opacity(0.5),
                    NeonStyle.strokeGradient6.opacity(0.5),
                    NeonStyle.strokeGradient6
                ]))
        }
    }
}

struct NeonModalBackgroundStyleGuide_Previews: PreviewProvider {
    static var previews: some View {
        NeonModalBackgroundStyleGuide()
            .preferredColorScheme(.dark)
    }
}
