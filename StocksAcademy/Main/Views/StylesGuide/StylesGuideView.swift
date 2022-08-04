//
//  StylesGuideView.swift
//  StocksAcademy
//
//  Created by bovsheva on 30.07.2022.
//

import SwiftUI

struct StylesGuideView: View {
    
    @State var selection = 0
    
    var body: some View {
        
        TabView(selection: $selection) {
            
            ZStack {
                GlassStyle.GalaxyBackground(addBigPlanet: false)
                    .ignoresSafeArea()
                
                NeonButtonStyleGuide()
            }
            .tag(0)
            
            ZStack {
                GlassStyle.GalaxyBackground(addBigPlanet: false)
                    .ignoresSafeArea()

                NeonTextFieldGuide()
            }
            .tag(1)
            
            ZStack {
                
                GlassStyle.GalaxyBackground(addBigPlanet: false)
                    .ignoresSafeArea()
                
                NeonModalBackgroundStyleGuide()
            }
            .tag(2)
            
            ZStack {
                GlassStyle.GalaxyBackground(addBigPlanet: false)
                    .ignoresSafeArea()
                
                NeumorphicButtonStyleGuide()
            }
            .tag(3)
            
            ZStack {
                GlassStyle.GalaxyBackground(addBigPlanet: false)
                    .ignoresSafeArea()
                
                NeumorphicTextFieldStyleGuide()
            }
            .tag(4)
            
            NeulightButtonStyleGuide(palette: NeulightStyle.Palette.purple)
                .tag(5)
            
            NeulightButtonStyleGuide(palette: NeulightStyle.Palette.cyan)
                .tag(6)
        }
        .tabViewStyle(PageTabViewStyle())
        .ignoresSafeArea()
    }
}

struct StylesGuide_Previews: PreviewProvider {
    static var previews: some View {
        StylesGuideView()
    }
}
