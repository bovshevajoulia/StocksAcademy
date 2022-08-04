//
//  GlassImageIconStyleGuide.swift
//  StocksAcademy
//
//  Created by bovsheva on 17.07.2022.
//

import SwiftUI

struct GlassImageIconStyleGuide: View {
    var body: some View {
        
        VStack(alignment: .center, spacing: 30) {
            
            Image("stocks_logo")
                .resizable()
            .modifier(GlassStyle.ImageIconStyle())
            
        }
    }
}

extension GlassStyle {
    
    struct ImageIconStyle: ViewModifier {
        
        var size: CGFloat =  25
        var cornerRadius: CGFloat = 16
        
        func body(content: Content) -> some View {
            content
                .aspectRatio(contentMode: ContentMode.fit)
                .frame(width: size, height: size)
                .cornerRadius(cornerRadius)
                .padding(8)
                .background(.ultraThinMaterial,
                            in: RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                )
                .modifier(GlassStyle.StrokeStyle(shape: ShapeType.rectangle(cornerRadius: cornerRadius),
                                                 lineWidth: 1)
                )
        }
    }
    
    struct XButtonStyle: ButtonStyle {
        @Environment(\.colorScheme) var colorScheme
        
        var primaryTextColor: Color {
            colorScheme == .dark ? Color.black.opacity(0.7) : Color.white.opacity(0.8)
        }
        
        func makeBody(configuration: Configuration) -> some View {
            
            configuration.label
                .font(.body.bold())
                .foregroundColor(self.primaryTextColor)
                .padding(8)
                .background(colorScheme == .dark ? Color.white.opacity(0.45) : Color.black.opacity(0.45),
                            in: Circle()
                )
                .frame(maxWidth: .infinity,
                       maxHeight: .infinity,
                       alignment: .topTrailing)
                .padding(20)
                .padding(.top, 20)
                .ignoresSafeArea()
        }
    }

}

struct GlassImageIconStyleGuide_Previews: PreviewProvider {
    static var previews: some View {
        GlassImageIconStyleGuide()
    }
}
