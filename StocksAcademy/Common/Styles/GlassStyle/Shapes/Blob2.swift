//
//  Abstract4.swift
//  StocksAcademy
//
//  Created by bovsheva on 15.07.2022.
//

import SwiftUI

struct Blob2: View {
    
    var size: CGFloat = 200
    
    var body: some View {
        Circle()
            .fill(
                AngularGradient(gradient: Gradient(colors: [GlassStyle.blobPalette1,GlassStyle.blobPalette2]), center: .center)
            )
            .frame(width: size, height: size)
            .blur(radius: 20)
            .overlay(
                Circle()
                    .fill(
                        AngularGradient(gradient: Gradient(colors: [GlassStyle.blobPalette1.opacity(0.5), GlassStyle.blobPalette2.opacity(0.5)]),
                                        center: .center)
                    )
                    .frame(width: size / 2, height: size / 2)
                    .offset(x: 100, y: 100)
                    .blendMode(.overlay)
                    .blur(radius: 100)
            )
    }
}

struct Abstract4_Previews: PreviewProvider {
    static var previews: some View {
        Blob2()
    }
}
