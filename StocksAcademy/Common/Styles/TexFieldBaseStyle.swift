//
//  TexFieldBaseStyle.swift
//  StocksAcademy
//
//  Created by bovsheva on 27.07.2022.
//

import Foundation
import SwiftUI

struct TextFieldBaseStyle: ViewModifier {
    
    var image: Image
    
    func body(content: Content) -> some View {
        content
            .padding(15)
            .padding(.leading, 36)
            .background(Color.white)
            .cornerRadius(18)
            .font(.custom("Open Sans", size: 17))
            .overlay(
                image.frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 8)
            )
            .foregroundColor(Color.black)
    }
}
