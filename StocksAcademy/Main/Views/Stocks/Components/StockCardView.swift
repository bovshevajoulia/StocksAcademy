//
//  StockCardView.swift
//  StocksAcademy
//
//  Created by bovsheva on 25.07.2022.
//

import SwiftUI

struct StockCardView: View {
    
    let item: StocksAcademy.StockSymbolItem
    
    var body: some View {
        
        VStack {
            
            VStack(alignment: .leading, spacing: 8) {
                
                HStack {
                    item.image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 44)
                    
                    VStack(alignment: .leading) {
                        title
                        symbol
                    }
                }
                
                Spacer()
                
                currentPrice
                
                prices
            }
            .background(
                chart
                    .opacity(0.8)
            )
            .padding(8)
        }
        .frame(height: 170)
        .modifier(GlassStyle.GlassBackgroundStyle())
    }
    
    var chart: some View {
        Image(item.chart)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height: 80)
    }
    
    var title: some View {
        Text(item.name)
            .font(.headline)
            .fontWeight(.semibold)
            .modifier(GlassStyle.TextPrimaryColorStyle())
    }
    
    var symbol: some View {
        Text(item.symbol)
            .font(.body)
            .fontWeight(.semibold)
            .modifier(GlassStyle.TextSecondaryColorStyle())
    }
    
    var currentPrice: some View {
        HStack {
            
            Text(String.formatted(number: item.currentPrice))
                .font(.footnote)
                .fontWeight(.semibold)
                .modifier(GlassStyle.TextPrimaryColorStyle())
                .frame(maxWidth: .infinity,
                       alignment: .leading)
            
            Text("\(String.formatted(number: item.percentChange))%")
                .font(.footnote)
                .fontWeight(.semibold)
                .foregroundColor(item.color)
                .frame(width: 60, alignment: .trailing)
                .padding(.horizontal, 5)
                .background(.white.opacity(0.85))
                .cornerRadius(8)
        }
        .lineLimit(1)
    }
    
    var prices: some View {
        HStack {
            VStack {
                HStack(spacing: 3) {
                    Text("Open")
                        .modifier(GlassStyle.TextSecondaryColorStyle())
                    Text(String.formatted(number: item.openPrice))
                        .modifier(GlassStyle.TextPrimaryColorStyle())
                }
                
                HStack(spacing: 3) {
                    Text("Close")
                        .modifier(GlassStyle.TextSecondaryColorStyle())
                    Text(String.formatted(number: item.previousClosePrice))
                        .modifier(GlassStyle.TextPrimaryColorStyle())
                }
            }
            .frame(maxWidth: .infinity,
                   alignment: .leading)
            
            VStack {
                
                HStack(spacing: 3) {
                    Text("Hight")
                        .modifier(GlassStyle.TextSecondaryColorStyle())
                    Text(String.formatted(number: item.highPrice))
                        .modifier(GlassStyle.TextPrimaryColorStyle())
                }
                
                HStack(spacing: 3) {
                    Text("Low")
                        .modifier(GlassStyle.TextSecondaryColorStyle())
                    Text(String.formatted(number: item.lowPrice))
                        .modifier(GlassStyle.TextPrimaryColorStyle())
                }
             }
            .frame(maxWidth: .infinity,
                   alignment: .trailing)
        }
        .lineLimit(1)
        .font(.system(size: 10))
    }
}

struct StockCardView_Previews: PreviewProvider {
    static var previews: some View {
        StockCardView(item: StocksAcademy.dummyStockSymbol)
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity)
            .background(
                Image("background-image-1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            )
            .ignoresSafeArea()
    }
}
