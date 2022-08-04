//
//  NeumorphicStyle.swift
//  StocksAcademy
//
//  Created by bovsheva on 16.07.2022.
//

import SwiftUI

struct NeumorphicStyle {
    
    // Backgrounds colors
    static let backgroundTop = Color("neu-background-1")
    static let backgroundBottom = Color("neu-background-2")
    
    static let backgroundCardTop = Color("neu-background-card-1")
    static let backgroundCardBottom = Color("neu-background-card-2")
    
    static let backgroundSingIn = Color("neu-singin-background")
    
    // Buttons colors
    static let buttonNormalTopColor = Color("neu-normal-button-top-1")
    static let buttonNormalBottomColor = Color("neu-normal-button-bottom-1")
    
    static let buttonDisableTopColor = Color("neu-disable-button-top")
    static let buttonDisableBottomColor = Color("neu-disable-button-bottom")
    
    // Palette
    struct PalettePurple {
        
        static let background =  Color("neu-purple-background")
        
        static let buttonNormalTopColor = Color("neu-purple-normal-button-top")
        static let buttonNormalBottomColor = Color("neu-purple-normal-button-bottom")
        
        static let textColor = Color.white
    }
    
    struct PaletteCyan {
        
        static let background =  Color("neu-cyan-background")
        
        static let buttonNormalTopColor = Color("neu-cyan-normal-button-top")
        static let buttonNormalBottomColor = Color("neu-cyan-normal-button-bottom")
        
        static let textColor = Color.black.opacity(0.5)
    }
}
