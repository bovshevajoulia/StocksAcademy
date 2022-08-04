//
//  OnboardingView.swift
//  StocksAcademy
//
//  Created by bovsheva on 15.07.2022.
//

import SwiftUI

struct OnboardingView: View {
    
    @State var selection = 0
    
    var onboardingHasDone: () -> ()
    
    var body: some View {
        
        ZStack {
            
            background
            
            TabView(selection: $selection) {
                OnboardingCardView(onboardingItem: StocksAcademy.onboardingItems[0]).tag(0)
                OnboardingCardView(onboardingItem: StocksAcademy.onboardingItems[1]).tag(1)
                OnboardingCardView(onboardingItem: StocksAcademy.onboardingItems[2]).tag(2)
                
                Button("Start!") {
                    onboardingHasDone()
                }
                .frame(width: 140, height: 44)
                .buttonStyle(NeonStyle.PrimaryButtonStyle(cornerRadius: 16))
                .tag(3)
            }
            .tabViewStyle(PageTabViewStyle())
            .background(
                ZStack {
                    
                    BlobsGraphic1(change: $selection)
                        .offset(x: 30, y: -250)
                    
                    BlobsGraphic2(change: $selection)
                        .offset(x: 30, y: -250)
                    
                    BlobsGraphic3(change: $selection)
                        .offset(x: 30, y: -250)
                }
            )
        }
        
    }
    
    var background: some View {
        
        ZStack {
            
            LinearGradient(colors: [GlassStyle.backgroundOnbordingTop, GlassStyle.backgroundOnbordingBottom],
                           startPoint: .top,
                           endPoint: .bottom)
                .ignoresSafeArea()
        }
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(onboardingHasDone: {})
            .preferredColorScheme(.light)
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}
