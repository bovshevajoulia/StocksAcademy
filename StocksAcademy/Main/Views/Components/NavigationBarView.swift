//
//  NavigationBarView.swift
//  StocksAcademy
//
//  Created by bovsheva on 16.07.2022.
//

import SwiftUI

struct NavigationBarView: View {
    
    @EnvironmentObject var stateManager: StateManager
    
    var body: some View {
        
        ZStack {
            
            Color.clear
                .background(.ultraThinMaterial)
                .blur(radius: 10)
                .opacity(stateManager.hasScrolled ? 1 : 0)
            
            Text(stateManager.navigationTitle)
                .font(.title)
                .bold()
                .foregroundColor(.primary)
                .frame(maxWidth: .infinity,
                       alignment: .leading)
                .padding(.leading, 20)
            
            HStack {
                
                Button {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        stateManager.isSingInModalPresented.toggle()
                    }
                } label: {
                    Image(systemName: "person")
                }
                .buttonStyle(NeonStyle.CircleButtonStyle(size: 36))
            }
            .frame(maxWidth: .infinity,
                   alignment: .trailing)
            .padding(.trailing, 20)
            .offset(y: stateManager.hasScrolled ? -4 : 0)
        }
        .frame(height: stateManager.hasScrolled ? 55 : 70)
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

struct NavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarView()
            .environmentObject(StateManager())
    }
}
