//
//  ModuleListItemView.swift
//  StocksAcademy
//
//  Created by bovsheva on 24.07.2022.
//

import SwiftUI

struct ModuleListItemView: View {
    
    let item: StocksAcademy.Module
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            
            Text(item.title)
                .font(.title3.weight(.bold))
            
            Text(item.description)
                .font(.footnote.weight(.regular))
            
            Text(item.estimatedTime)
                .font(.footnote.weight(.semibold))
        }
        .modifier(GlassStyle.TextColorStyle())
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            Rectangle()
                .fill(.ultraThinMaterial)
                .mask(
                    RoundedRectangle(cornerRadius: 20,
                                     style: .continuous)
                )
        )
    }
}

struct ModuleListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ModuleListItemView(item: StocksAcademy.financialFifthModule())
    }
}
