//
//  NeumorphicTextFieldStyleGuide.swift
//  StocksAcademy
//
//  Created by bovsheva on 27.07.2022.
//

import SwiftUI

struct NeumorphicTextFieldStyleGuide: View {
    
    @State var password: String = ""
    @State var email: String = ""
    
    var body: some View {
        
        VStack(spacing: 50) {
                
            Text("Neumorphic TextField styles")
                .font(.title)
            
            TextField("Email", text: $email)
                .modifier(NeumorphicStyle.TextFieldStyle(cornerRadius: 16, image: Image(systemName: "envelope.fill")))

            TextField("Password", text: $email)
                .modifier(NeumorphicStyle.TextFieldStyle(cornerRadius: 16, image: Image(systemName: "lock.fill")))

        }
        .padding()
    }
}

extension NeumorphicStyle {
    
    struct TextFieldStyle: ViewModifier {
        @Environment(\.colorScheme) var colorScheme
        
        var image: Image
        
        var primaryTextColor: Color {
            colorScheme == .dark ? Color.white.opacity(0.8) : Color.black.opacity(0.7)
        }
        
        let cornerRadius: CGFloat
        
        init(cornerRadius: CGFloat, image: Image) {
            self.cornerRadius = cornerRadius
            self.image = image
        }
        
        func body(content: Content) -> some View {
            content
                .padding(15)
                .padding(.leading, 36)
                .frame(maxWidth: .infinity)
                .background(.white.opacity(0.65),
                            in: RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                )
                .font(.body)
                .foregroundColor(self.primaryTextColor)
                .overlay(
                    image
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 8)
                )
                .modifier(DropShadowBaseStyle(
                    topLeft: Color.white.opacity(0.4),
                    topShadowRadius: 10,
                    topShadowX: -8,
                    topShadowY: -8,
                    bottomRight: Color.gray.opacity(0.7),
                    bottomShadowRadius: 10,
                    bottomShadowX: 8,
                    bottomShadowY: 8)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 18)
                        .stroke(Color.white, lineWidth: 1)
                )
        }
    }
}


struct TextFieldStyleGuide_Previews: PreviewProvider {
    static var previews: some View {
        NeumorphicTextFieldStyleGuide()
    }
}
