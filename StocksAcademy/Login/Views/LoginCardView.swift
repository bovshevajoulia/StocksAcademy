//
//  LoginCardView.swift
//  StocksAcademy
//
//  Created by bovsheva on 16.07.2022.
//

import SwiftUI

struct LoginCardView: View {
    
    var body: some View {
        
        VStack {
            
            ScaledImageView(name: "bank-6")
            
            GlassStyle.textGradient
                .frame(height: 140)
                .mask {
                    Text("Join Stocks Academy")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity,
                               alignment: .leading)
                }
                .padding()
        }
        .frame(height: 400)
        .background(.white.opacity(0.44))
        .cornerRadius(40)
        .modifier(NeumorphicStyle.ModalDropShadowStyle())
        .padding(20)
    }
}

struct LoginCardView_Previews: PreviewProvider {
    static var previews: some View {
        LoginCardView()
            .preferredColorScheme(.dark)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                LinearGradient(colors: [NeumorphicStyle.backgroundTop, NeumorphicStyle.backgroundBottom], startPoint: .top, endPoint: .bottomLeading)
            )
    }
}
