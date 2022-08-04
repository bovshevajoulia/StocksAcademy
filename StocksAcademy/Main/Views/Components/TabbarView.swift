//
//  TabbarView.swift
//  StocksAcademy
//
//  Created by bovsheva on 17.07.2022.
//

import SwiftUI

extension StocksAcademy {
    
    struct TabbarView: View {
        
        @Binding var selection: Int
        
        var icons: [String] = [
            "house",
            "chart.bar.xaxis", // stocks
            "plus", // stocks uikit
            "newspaper", // news
            "greetingcard" // ?
        ]
        
        var body: some View {
            
            ZStack {
                
                Color.clear
                    .background(.ultraThinMaterial)
                    .blur(radius: 10)
                
                HStack {
                    
                    ForEach(0 ..< 5, id: \.self) { number in
                        if number == 2 {
                            Button {
                                self.selection = number
                            } label: {
                                Image(systemName: self.icons[number])
                            }
                            .buttonStyle(NeonStyle.CircleButtonStyle(size: 40))
                            .modifier(NeonStyle.LightEffectStyle(width: 40,
                                                                 heith: 40,
                                                                 isLighted: self.selection  == number))
                            .padding()
                        }
                        else {
                            Button {
                                self.selection = number
                            } label: {
                                Image(systemName: self.icons[number])
                            }
                            .buttonStyle(NeonStyle.TabbarButtonStyle(size: 36,
                                                                     isSelected: self.selection  == number)
                            )
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .frame(height: 90)
            .mask {
                Capsule()
                    .modifier(GlassStyle.StrokeStyle(shape: ShapeType.oval,
                                                     lineWidth: 2)
                    )
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .ignoresSafeArea(edges: Edge.Set.bottom)
        }
    }
}

struct StocksAcademy_TabbarView_Previews: PreviewProvider {
    static var previews: some View {
        StocksAcademy.TabbarView(selection: .constant(0))
            .preferredColorScheme(.dark)
    }
}
