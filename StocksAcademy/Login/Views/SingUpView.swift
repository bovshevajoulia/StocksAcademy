//
//  SingUpView.swift
//  StocksAcademy
//
//  Created by bovsheva on 16.07.2022.
//

import SwiftUI

struct SingUpView: View {
    
    var onSingUp: () -> ()
    
    @Binding var isPresentingOverlay: Bool
    
    @State var password: String = ""
    @State var email: String = ""
    
    var body: some View {
        
        ZStack {
            
            background
            
            VStack(alignment: .leading, spacing: 30) {
                
                title
                
                description
                
                emailTextEdit
                
                passwordTextEdit
                
                singUp
            }
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 500)
            .background(
                RoundedRectangle(cornerRadius: 40,
                                 style: .continuous)
                    .fill(
                        NeumorphicStyle.backgroundSingIn
                    )
            )
            .padding(20)
            .modifier(NeumorphicStyle.ModalDropShadowStyle())
        }
    }
    
    var title: some View {
        Text("Sing up")
            .font(.largeTitle).bold()
            .foregroundColor(.primary)
            .frame(maxWidth: .infinity, alignment: .leading)

    }
    
    var description: some View {
        Text("Access 120+ hours of courses, tutorials and livestreams")
            .font(.headline)
            .foregroundColor(.secondary)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var emailTextEdit: some View {
        TextField("Email", text: $email)
            .modifier(NeumorphicStyle.TextFieldStyle(cornerRadius: 20, image: Image(systemName: "envelope.fill")))
            .frame(height: 44)
    }
    
    var passwordTextEdit: some View {
        TextField("Password", text: $password)
            .modifier(NeumorphicStyle.TextFieldStyle(cornerRadius: 20, image: Image(systemName: "key.fill")))
            .frame(height: 44)
    }
    
    var singUp: some View {
        Button {
            withAnimation(.easeInOut) {
                isPresentingOverlay = false
                onSingUp()
            }
        } label: {
            Text("Sing up")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 44)
        .buttonStyle(NeumorphicStyle.PaletteButtonStyle(palette: .purple))
    }
    
    var background: some View {
        ZStack {
            LinearGradient(colors: [NeumorphicStyle.backgroundTop, NeumorphicStyle.backgroundBottom],
                           startPoint: .top,
                           endPoint: .bottom)
                .ignoresSafeArea()
        }
    }
}

struct SingIn_Previews: PreviewProvider {
    static var previews: some View {
        SingUpView(onSingUp: {}, isPresentingOverlay: .constant(false))
            .preferredColorScheme(.light)
    }
}
