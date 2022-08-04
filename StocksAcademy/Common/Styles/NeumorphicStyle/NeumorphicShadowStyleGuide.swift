//
//  NeumorphicShadowStyleGuide.swift
//  StocksAcademy
//
//  Created by bovsheva on 16.07.2022.
//

import SwiftUI

struct NeumorphicShadowStyleGuide: View {
    var body: some View {
        
        VStack {
            
            VStack {
                NeumorphicStyle.backgroundTop
                    .cornerRadius(30)
            }
            .frame(height: 400)
            .modifier(NeumorphicStyle.ModalDropShadowStyle())
            .padding(40)
        }
        .frame(width: .infinity, height: .infinity)
    }
}

extension NeumorphicStyle {
    
    struct ModalDropShadowStyle: ViewModifier {
        @Environment(\.colorScheme) var colorScheme
        
        func body(content: Content) -> some View {
            content
                .modifier(DropShadowBaseStyle(
                    topLeft: colorScheme == .dark ? Color.white.opacity(0.4) : Color.white.opacity(0.85),
                    topShadowRadius: 10,
                    topShadowX: -8,
                    topShadowY: -8,
                    bottomRight: colorScheme == .dark ? Color.black.opacity(0.5) : Color.gray.opacity(0.5),
                    bottomShadowRadius: 10,
                    bottomShadowX: 8,
                    bottomShadowY: 8)
                )
        }
    }
}

struct NeumorphicShadowStyleGuide_Previews: PreviewProvider {
    static var previews: some View {
        NeumorphicShadowStyleGuide()
            .preferredColorScheme(.dark)
    }
}
