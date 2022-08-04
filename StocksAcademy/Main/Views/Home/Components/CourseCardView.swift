//
//  CourseCardView.swift
//  StocksAcademy
//
//  Created by bovsheva on 19.07.2022.
//

import SwiftUI

struct CourseCardView: View {
    
    let item: StocksAcademy.CourseCardItem
    
    var body: some View {
        
        content
            .background(
                item.image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 130)
                    .padding(.bottom, 70)
            )
            .background(
                item.background.opacity(0.8)
            )
            .mask {
                RoundedRectangle(cornerRadius: 30,
                                 style: .continuous)
            }
            .frame(height: 250)
            .modifier(GlassStyle.ModalShadowStyle())
            .padding(20)
    }
    
    var content: some View {
        
        VStack {
            
            Spacer()
            
            VStack (alignment: .leading, spacing: 12) {
                Text(item.course.title)
                    .font(.title.bold())
                    .foregroundColor(Color.black.opacity(0.5))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(item.course.estimatedTime)
                    .font(.footnote.weight(.semibold))
                
                Text(item.course.shortDescription)
                    .lineLimit(3)
                    .font(.footnote)
            }
            .modifier(GlassStyle.TextColorStyle())
            .padding(20)
        }
    }
}

struct CourseCardView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        CourseCardView(item: StocksAcademy.dummyCourses[0])
            .preferredColorScheme(.dark)
    }
}
