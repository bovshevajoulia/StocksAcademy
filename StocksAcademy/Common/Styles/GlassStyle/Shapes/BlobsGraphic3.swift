//
//  BlobsGraphic3.swift
//  StocksAcademy
//
//  Created by bovsheva on 15.07.2022.
//

import SwiftUI

struct BlobsGraphic3: View {
    
    @State var isAppear = false
    @State var isActive = false
    
    @Binding var change: Int
    
    var body: some View {
        
        ZStack {
            
            Blob2(size: 100)
                .offset(x: 30, y: 30)
            
            Blob2(size: 150)
                .offset(x: 150, y: isAppear ? 0 : 100)
            
            Blob1(size: 200)
                .offset(x: isAppear ? -100 : 0, y: -100)

        }
        .opacity(isActive ? 1 : 0)
        .onAppear {
            update()
        }
        .onChange(of: change) { newValue in
            update()
        }
    }
    
    func update() {
        if change == 2 {
            withAnimation(.linear(duration: 5)) {
                isAppear = true
            }
            withAnimation(.linear(duration: 2)) {
                isActive = true
            }
        }
        else {
            withAnimation(.linear(duration: 5)) {
                isAppear = false
            }
            withAnimation(.linear(duration: 1)) {
                isActive = false
            }
        }
    }
}


struct BlobsGraphic3_Previews: PreviewProvider {
    static var previews: some View {
        BlobsGraphic3(change: .constant(2))
    }
}
