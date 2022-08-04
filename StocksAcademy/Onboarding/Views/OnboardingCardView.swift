//
//  OnboardingCardView.swift
//  StocksAcademy
//
//  Created by bovsheva on 15.07.2022.
//

import SwiftUI

struct OnboardingCardView: View {
    
    let onboardingItem: OnboardingItem
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 16) {
            
            Text(onboardingItem.information)
                .font(.footnote)
                .fontWeight(.semibold)
                .modifier(GlassStyle.TextColorStyle())
            
            GlassStyle.textGradient
                .frame(height: 140)
                .mask {
                    Text(onboardingItem.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            
            Text(onboardingItem.description)
                .font(.subheadline)
                .frame(height: 130)
                .modifier(GlassStyle.TextColorStyle())
            
        }
        .padding(30)
        .padding(.bottom, 60)
        .background(
            LinearGradient(colors: [GlassStyle.backgroundOnbordingCardTop, GlassStyle.backgroundOnbordingCardBottom],
                           startPoint: .top,
                           endPoint: .bottom)
        )
        .mask(RoundedRectangle(cornerRadius: 30,
                               style: .continuous)
        )
        .modifier(GlassStyle.StrokeStyle(shape: ShapeType.rectangle(cornerRadius: 30)))
        .padding(20)
    }
}

struct OnboardingCardView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingCardView(onboardingItem: StocksAcademy.onboardingItems[0])
    }
}
