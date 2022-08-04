//
//  MarketNewsErrorView.swift
//  StocksAcademy
//
//  Created by bovsheva on 28.07.2022.
//

import SwiftUI

struct MarketNewsErrorView: View {
    
    @Binding var error: String
    @Binding var tryAgain: Bool
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 12) {
            
            Text(error)
                .font(.footnote)
                .frame(maxWidth: .infinity)
                .frame(height: 100, alignment: .leading)
            
            Button {
                tryAgain.toggle()
            } label: {
                Text("Try again!")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 44)
            .buttonStyle(NeonStyle.PrimaryButtonStyle(cornerRadius: 20))
        }
        .modifier(GlassStyle.TextColorStyle())
        .padding(20)
        .background(
            Rectangle()
                .fill(.ultraThinMaterial)
                .mask(
                    RoundedRectangle(cornerRadius: 30,
                                     style: .continuous)
                )
        )
        .padding()
    }
}

struct MarketNewsErrorView_Previews: PreviewProvider {
    static var previews: some View {
        MarketNewsErrorView(error: .constant("Error was occured while loading"), tryAgain: .constant(false))
            .preferredColorScheme(.dark)
    }
}
