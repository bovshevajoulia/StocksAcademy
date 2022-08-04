//
//  Blob3.swift
//  StocksAcademy
//
//  Created by bovsheva on 15.07.2022.
//

import SwiftUI

struct Blob3: View {
    
    var size: CGFloat = 200
    
    var body: some View {
        
        Circle()
            .fill(
                RadialGradient(
                    colors: [GlassStyle.blobPalette1, GlassStyle.blobPalette2],
                    center: .center,
                    startRadius: size / 4,
                    endRadius: size / 2
                )
            )
            .frame(width: size, height: size)
            .blur(radius: 20)
    }
}

struct Blob4: View {
    
    var size: CGFloat = 5
    var blur: CGFloat = 2
    
    var body: some View {
        
        Circle()
            .fill(
                .white
            )
            .frame(width: size, height: size)
            .blur(radius: blur)
    }
}

struct Blob3_Previews: PreviewProvider {
    static var previews: some View {
        Blob3()
        Blob4()
            .offset(x: 100, y: 100)
    }
}
