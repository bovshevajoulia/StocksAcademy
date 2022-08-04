//
//  LoginView.swift
//  StocksAcademy
//
//  Created by bovsheva on 16.07.2022.
//

import SwiftUI

struct LoginView: View {
    
    var onLogin: () -> ()
    
    var onSingUp: () -> ()
    
    @State private var isPresentingOverlay: Bool = false
    
    var body: some View {
            
            ZStack {
                
                background
                
                VStack {
                    
                    LoginCardView()
                    
                    HStack {
                        
                        login
                        
                        Spacer()
                        
                        singUp
                            .fullScreenCover(isPresented: $isPresentingOverlay) {
                                
                                SingUpView(onSingUp: self.onSingUp,
                                           isPresentingOverlay: $isPresentingOverlay)
                            }
                    }
                    .padding(.horizontal, 40)
                }
            }
    }
    
    var login: some View {
        Button {
            withAnimation(.easeInOut) {
                onLogin()
            }
            
        } label: {
            Text("Login")
        }
        .frame(width: 137, height: 52)
        .buttonStyle(NeumorphicStyle.PrimaryButtonStyle())
    }
    
    var singUp: some View {
        Button {
            isPresentingOverlay.toggle()
        } label: {
            Text("Sing Up")
        }
        .frame(width: 137, height: 52)
        .buttonStyle(NeumorphicStyle.PaletteButtonStyle(palette: .purple))
    }
    
    var background: some View {
        
        ZStack {
            LinearGradient(colors: [NeumorphicStyle.backgroundTop,
                                    NeumorphicStyle.backgroundBottom],
                           startPoint: .top,
                           endPoint: .bottom)
                .ignoresSafeArea()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(onLogin: {}, onSingUp: {})
            .preferredColorScheme(.dark)
    }
}
