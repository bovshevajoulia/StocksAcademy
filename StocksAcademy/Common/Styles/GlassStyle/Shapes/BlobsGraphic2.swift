//
//  BlobsGraphic2.swift
//  StocksAcademy
//
//  Created by bovsheva on 15.07.2022.
//

import SwiftUI

struct BlobsGraphic2: View {
    
    @State var isAppear = false
    @State var isActive = false
    
    @Binding var change: Int
    
    var body: some View {
        
        ZStack {
            
            Blob2(size: 200)
                .offset(x: -100, y: isActive ? 0 : 50)
            
            Blob2(size: 150)
                .offset(x: 0, y: isActive ? 0 : 100)
            
            Blob1(size: 250)
                .offset(x: 150, y: isActive ? 0 : 150)
            
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
        if change == 1 {
            withAnimation(.linear(duration: 5)) {
                isAppear = true
            }
            withAnimation(.linear(duration: 1)) {
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

struct BlobsGraphic2_Previews: PreviewProvider {
    static var previews: some View {
        BlobsGraphic2(change: .constant(1))
    }
}
