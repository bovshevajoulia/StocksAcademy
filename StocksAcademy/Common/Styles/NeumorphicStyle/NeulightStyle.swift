//
//  NeulightStyle.swift
//  StocksAcademy
//
//  Created by bovsheva on 30.07.2022.
//

import Foundation
import SwiftUI

struct NeulightStyle {
    
    static let disableTopLeftColor = Color("neulight-disable-button-top")
    static let disableBottomRightColor = Color("neulight-disable-button-bottom")
    
    struct PalettePurple {
        
        static let background =  Color("neulight-purple-background")

        static let normalTopLeftColor = Color("neulight-purple-normal-button-top-left")
        static let normalBottomRightColor = Color("neulight-purple-normal-button-bottom-right")
        
    }
    
    struct PaletteCyan {
        
        static let background =  Color("neulight-cyan-background")
        
        static let normalTopLeftColor = Color("neulight-cyan-normal-button-top-left")
        static let normalBottomRightColor = Color("neulight-cyan-normal-button-bottom-right")
        
    }
    
    enum Palette {
        case purple
        case cyan
    }
}
