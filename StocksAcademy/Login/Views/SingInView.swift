//
//  SingInView.swift
//  StocksAcademy
//
//  Created by bovsheva on 28.07.2022.
//

import SwiftUI

struct SingInView: View {
    
    @EnvironmentObject var stateManager: StateManager
    
    @State var password: String = ""
    @State var email: String = ""
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 40) {
            
            title
            
            description
            
            emailTextEdit
            
            passwordTextEdit
            
            singIn
        }
        .padding()
        .padding(.vertical, 20)
        .modifier(NeonStyle.ModalBackgroundStyle())
        .padding(40)
    }
    var title: some View {
        Text("Sing In")
            .font(.largeTitle).bold()
            .modifier(GlassStyle.TextColorStyle())
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var description: some View {
        Text("Access 120+ hours of courses, tutorials and livestreams")
            .font(.headline)
            .modifier(GlassStyle.TextColorStyle())
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var emailTextEdit: some View {
        TextField("Email", text: $email)
            .modifier(NeonStyle.TextFieldStyle(cornerRadius: 20, image: Image(systemName: "envelope.fill")))
            .frame(height: 44)
    }
    
    var passwordTextEdit: some View {
        TextField("Password", text: $password)
            .modifier(NeonStyle.TextFieldStyle(cornerRadius: 20, image: Image(systemName: "key.fill")))
            .frame(height: 44)
    }
    
    var singIn: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.5)) {
                stateManager.isSingInModalPresented.toggle()
            }
        } label: {
            Text("Sing In")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 44)
        .buttonStyle(NeonStyle.PrimaryButtonStyle(cornerRadius: 20))
    }
}

struct SingInView_Previews: PreviewProvider {
    static var previews: some View {
        SingInView()
            .environmentObject(StateManager())
            .preferredColorScheme(.dark)
    }
}
