//
//  NeonTextFieldGuide.swift
//  StocksAcademy
//
//  Created by bovsheva on 28.07.2022.
//

import SwiftUI

struct NeonTextFieldGuide: View {
    
    @State var password: String = ""
    @State var email: String = ""
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            Text("Neon TextField style")
                .font(.title)
            
            TextField("Email", text: $email)
                .modifier(NeonStyle.TextFieldStyle(cornerRadius: 20, image: Image(systemName: "envelope.fill")))
            
            TextField("Password", text: $password)
                .modifier(NeonStyle.TextFieldStyle(cornerRadius: 20, image: Image(systemName: "lock.fill")))
            
        }
        .padding()
    }
}

extension NeonStyle {
    
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
                .background(.ultraThinMaterial,
                            in: RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                )
                .font(.body)
                .foregroundColor(self.primaryTextColor)
                .overlay(
                    image.frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 8)
                )
                .modifier(
                    NeonStyle.GradientStrokeStyle(lineWidth: 2,
                                                  shape: ShapeType.rectangle(cornerRadius: self.cornerRadius))
                )
        }
    }
}

struct NeonTextFieldGuide_Previews: PreviewProvider {
    static var previews: some View {
        NeonTextFieldGuide()
            .preferredColorScheme(.light)
    }
}
