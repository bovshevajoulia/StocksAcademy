//
//  GlassStyle.swift
//  StocksAcademy
//
//  Created by bovsheva on 15.07.2022.
//

import Foundation
import SwiftUI

struct GlassStyle {
    
    static let background = Color("glass-background-1")
    
    static let backgroundLightGradient = LinearGradient(colors: [Color("glass-background-3"), Color("glass-background-4")],
                                                        startPoint: .topLeading,
                                                        endPoint: .bottomTrailing)

    
    static let backgroundGradient = LinearGradient(colors: [Color("glass-background-1"),Color("glass-background-2")],
                                             startPoint: .top,
                                             endPoint: .bottom)
    static let backgroundImage = Image("background-image-1")
    
    static let backgroundModal = Color("glass-modal-background")
    static let shadowBottomColor = Color("glass-modal-shadow")
    
    static let backgroundOnbordingCardTop = Color("onboarding-card-background-1")
    static let backgroundOnbordingCardBottom = Color("onboarding-card-background-2")
    
    static let backgroundOnbordingTop = Color("onboarding-background-1")
    static let backgroundOnbordingBottom = Color("onboarding-background-2")
    
    static let textGradient = LinearGradient(colors: [Color("glass-color-1"),Color("glass-color-3")],
                                             startPoint: .topLeading,
                                             endPoint: .bottomTrailing)
    
    static let blobPalette1 = Color("blob-palette-1")
    static let blobPalette2 = Color("blob-palette-2")
    static let blobPalette3 = Color("blob-palette-3")
    static let blobPalette4 = Color("blob-palette-4")
    
    static let buttonEnabledTextColor = Color("glass-text-enabled-color")
    
    static let dropShadowColor = Color("drop-shadow-0")
    static let dropShadowColor1 = Color("drop-shadow-1")
    static let dropShadowColor2 = Color("drop-shadow-2")
    
    static let gradients = [
        LinearGradient(colors: [Color("glass-color-1"), Color("glass-color-3")],
                                                 startPoint: .topLeading,
                                                 endPoint: .bottomTrailing),
        
        LinearGradient(colors: [Color("glass-color-2"), Color("glass-color-3")],
                                                 startPoint: .topLeading,
                                                 endPoint: .bottomTrailing),
        
        LinearGradient(colors: [Color("glass-color-1"), Color("glass-color-4")],
                                                 startPoint: .topLeading,
                                                 endPoint: .bottomTrailing),
        
        
        LinearGradient(colors: [Color("glass-color-2"), Color("glass-color-4")],
                                                 startPoint: .topLeading,
                                                 endPoint: .bottomTrailing),
    ]
    
    static func makeStars(size: CGFloat) {
        let width: CGFloat = 200
        let height: CGFloat = 400
        
        print("------------")
        for _ in 1...9  {
            
            let x: CGFloat = randomX(width)
            let y: CGFloat = randomY(height)
            let blur = size * 0.25
            
            print("Blob4(size: \(size), blur: \(blur)).offset(x: \(x), y: \(y))")
            
        }
        
    }
    
    static func randomY( _ width: CGFloat) -> CGFloat {
        let random = CGFloat.random(in: -0.8...0.8)
        return width * random
    }
    
    static func randomX( _ height: CGFloat) -> CGFloat {
        let random = CGFloat.random(in: -0.8...0.8)
        return height * random
    }
}
