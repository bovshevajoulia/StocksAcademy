//
//  CourseListItemView.swift
//  StocksAcademy
//
//  Created by bovsheva on 30.07.2022.
//

import SwiftUI

struct CourseListItemView: View {
    
    let item: StocksAcademy.CourseCardItem
    
    var body: some View {
        
        content
            .background(
                
                HStack {
                    item.image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 100)
                }
                    .frame(maxWidth: .infinity, alignment: .topTrailing)
            )
            .background(
                item.background.opacity(0.8)
            )
            .mask {
                RoundedRectangle(cornerRadius: 20,
                                 style: .continuous)
            }
            .frame(height: 150)
            .modifier(GlassStyle.ModalShadowStyle())
            .padding(5)
    }
    
    var content: some View {
        
        VStack {
            
            Spacer()
            
            VStack (alignment: .leading, spacing: 12) {
                Text(item.course.title)
                    .font(.body.bold())
                    .foregroundColor(Color.black.opacity(0.75))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(item.course.estimatedTime)
                    .font(.caption2.weight(.semibold))
                
                Text(item.course.shortDescription)
                    .lineLimit(3)
                    .font(.caption2)
            }
            .modifier(GlassStyle.TextColorStyle())
            .padding()
        }
    }
}


struct CourseListItemView_Previews: PreviewProvider {
    static var previews: some View {
        CourseListItemView(item: StocksAcademy.dummyCourses[0])
    }
}
