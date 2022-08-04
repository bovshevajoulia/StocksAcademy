//
//  ScaledImageView.swift
//  StocksAcademy
//
//  Created by bovsheva on 17.06.2022.
//

import SwiftUI

struct ScaledImageView: View {
    
    let name: String
    
    var body: some View {
        Image(name)
            .resizable()
            .scaledToFit()
    }
}

struct ScaledImageView_Previews: PreviewProvider {
    static var previews: some View {
        ScaledImageView(name: "bank-1")
    }
}
