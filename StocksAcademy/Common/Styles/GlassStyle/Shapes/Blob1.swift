//
//  Blob1.swift
//  StocksAcademy
//
//  Created by bovsheva on 15.07.2022.
//

import SwiftUI

struct Blob1: View {
    var size: CGFloat = 200
    var body: some View {
        Circle()
            .fill(
                AngularGradient(gradient: Gradient(colors: [GlassStyle.blobPalette1, GlassStyle.blobPalette2, GlassStyle.blobPalette3, GlassStyle.blobPalette4]), center: .center)
            )
            .frame(width: size, height: size)
            .blur(radius: 20)
            .overlay(
                Circle()
                    .fill(
                        AngularGradient(gradient: Gradient(colors: [GlassStyle.blobPalette1.opacity(0.5), GlassStyle.blobPalette2.opacity(0.5), GlassStyle.blobPalette3.opacity(0.5), GlassStyle.blobPalette4.opacity(0.5)]),
                                        center: .center)
                    )
                    .frame(width: size / 2, height: size / 2)
                    .blendMode(.overlay)
                    .blur(radius: 60)
            )
    }
}

struct Blob1_Previews: PreviewProvider {
    static var previews: some View {
        Blob1()
    }
}
