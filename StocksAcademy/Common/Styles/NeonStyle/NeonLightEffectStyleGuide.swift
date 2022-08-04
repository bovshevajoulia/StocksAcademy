//
//  NeonLightEffectStyleGuide.swift
//  StocksAcademy
//
//  Created by bovsheva on 17.07.2022.
//

import SwiftUI

struct NeonLightEffectStyleGuide: View {
    var body: some View {
        
        VStack(alignment: .center, spacing: 40) {
            
            Text("Button + LightEffect")
            
            Button {} label: {
                Image(systemName: "magnifyingglass")
            }
            .buttonStyle(NeonStyle.CircleButtonStyle(size: 36))
            .modifier(NeonStyle.LightEffectStyle(width: 36, heith: 36, isLighted: true))
        }
    }
}

extension NeonStyle {
    
    struct LightEffectStyle: ViewModifier {
        
        var width: CGFloat
        var heith: CGFloat
        var isLighted: Bool
        
        func body(content: Content) -> some View {
            content
                .background(
                    RoundedRectangle(cornerRadius: self.heith / 2,
                                     style: .continuous)
                        .fill(
                            LinearGradient(colors: [NeonStyle.lightEffectTop, NeonStyle.lightEffectBottom],
                                           startPoint: .top,
                                           endPoint: .bottom)
                        )
                        .frame(width: self.width * 1.25, height: self.heith * 1.25)
                        .opacity(self.isLighted ? 1 : 0)
                        .blendMode(.overlay)
                        .blur(radius: 20)
                )
        }
    }
}

struct NeonLightEffectStyleGuide_Previews: PreviewProvider {
    static var previews: some View {
        NeonLightEffectStyleGuide()
    }
}
