//
//  StocksCardListView.swift
//  StocksAcademy
//
//  Created by bovsheva on 26.07.2022.
//

import SwiftUI

struct StocksCardListView: View {
    
    @Binding var items: [String : StocksAcademy.StockSymbolItem]
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var gridItems: [StocksAcademy.StockSymbolItem] {
        items.map({ $0.value }).sorted( by: { $0.name < $1.name } )
    }
    
    var body: some View {
        
        VStack {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 180), spacing: 10)], spacing: 10) {
                
                ForEach(gridItems) { item in
                    StockCardView(item: item)
                }
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.vertical, 40)
        .padding(.horizontal, 5)
        .modifier(GlassStyle.GlassBackgroundStyle(cornerRadius: 30,
                                                  background: Color.white.opacity(0.25),
                                                  lineWidth: 1.5))
    }
}

struct StocksCardListView_Previews: PreviewProvider {
    static var previews: some View {
        StocksCardListView(items: .constant(StocksAcademy.dummyStockSymbols()))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.blue)
    }
}
