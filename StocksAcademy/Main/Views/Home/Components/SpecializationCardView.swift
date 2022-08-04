//
//  SpecializationCardView.swift
//  StocksAcademy
//
//  Created by bovsheva on 07.07.2022.
//

import SwiftUI

struct SpecializationCardView: View {
    
    let item: StocksAcademy.SpecializationCardItem
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            
            logo
            
            partner
            
            title
            
            estimatedTime
            
            description
        }
        .padding(.all, 20)
        .padding(.top, 20)
        .frame(height: 360)
        .modifier(GlassStyle.ModalBackgroundStyle())
        .modifier(GlassStyle.ModalShadowStyle())
        .overlay {
            item.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 180)
                .offset(x: 50, y: -140)
        }
        .padding(.horizontal, 25)
    }
    
    var title: some View {
        GlassStyle.textGradient
            .frame(height: 120)
            .mask {
                Text(item.specialization.title)
                    .font(.title)
                    .bold()
                    .lineLimit(3)
            }
    }
    
    var estimatedTime: some View {
        Text(item.specialization.estimatedTime)
            .font(.footnote)
            .fontWeight(.semibold)
            .modifier(GlassStyle.TextColorStyle())
    }
    
    var description: some View {
        Text(item.specialization.shortDescription)
            .font(.footnote)
            .multilineTextAlignment(.leading)
            .lineLimit(3)
            .frame(maxWidth: .infinity, alignment: .leading)
            .modifier(GlassStyle.TextColorStyle())
    }
    
    var partner: some View {
        Text(item.specialization.partner)
            .font(.footnote)
            .modifier(GlassStyle.TextColorStyle())
    }
    
    var logo: some View {
        Image(item.specialization.partnerImage)
            .resizable()
            .modifier(GlassStyle.ImageIconStyle())
    }
}


struct SpecializationCardView_Previews: PreviewProvider {
    static var previews: some View {
        SpecializationCardView(item: StocksAcademy.dummySpecializations[0])
            .preferredColorScheme(.dark)
    }
}
