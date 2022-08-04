//
//  NewsLisItem.swift
//  StocksAcademy
//
//  Created by bovsheva on 27.07.2022.
//

import SwiftUI

struct NewsLisItem: View {
    
    let item: NewsStory
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            
            GlassStyle.textGradient
                .frame(height: 80, alignment: .leading)
                .mask {
                    Text(item.headline)
                        .font(.title3)
                        .bold()
                        .multilineTextAlignment(.leading)
                }
            
            HStack {
                
                Text(item.related)
                    .font(.title)
                    .bold()
                
                Text(item.source)
                    .font(.caption)
                
                Text(String.string(from: item.datetime))
                    .font(.caption)
                    .frame(maxWidth: .infinity,alignment: .trailing)
            }
            
            Text(item.summary)
                .font(.footnote)
        }
        .modifier(GlassStyle.TextColorStyle())
        .padding()
        .modifier(GlassStyle.GlassBackgroundStyle())
        .padding()
    }
}

struct NewsLisItem_Previews: PreviewProvider {
    static var previews: some View {
        NewsLisItem(item: NewsStory.dummyNewsStory())
    }
}
