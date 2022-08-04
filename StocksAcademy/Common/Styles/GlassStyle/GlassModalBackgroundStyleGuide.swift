//
//  GlassModalBackgroundStyleGuide.swift
//  StocksAcademy
//
//  Created by bovsheva on 08.07.2022.
//

import SwiftUI

struct GlassModalBackgroundStyleGuide: View {
    var body: some View {
        VStack {
            
            VStack {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 250)
            .modifier(GlassStyle.ModalBackgroundStyle())
            .modifier(GlassStyle.ModalShadowStyle())
            .padding(40)
            
            
            VStack {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 250)
            .modifier(GlassStyle.GlassBackgroundStyle())
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image("background-image-1")
        )
    }
}


extension GlassStyle {
    
    struct BlurBackgroundStyle: ViewModifier {
        
        var cornerRadius: CGFloat = 30
        var blurRadius: CGFloat = 60
        
        func body(content: Content) -> some View {
            
            content
                .background(Color.white.opacity(0.5))
                .mask {
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .blur(radius: blurRadius)
                }
        }
    }
    
    struct ModalBackgroundStyle: ViewModifier {
        
        var cornerRadius: CGFloat = 30
        
        func body(content: Content) -> some View {
            
            content
                .background(GlassStyle.backgroundModal.opacity(0.4))
                .mask {
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                }
                .modifier(GlassStyle.StrokeStyle(shape: ShapeType.rectangle(cornerRadius: cornerRadius),
                                                 lineWidth: 1)
                )
        }
    }
    
    struct GlassBackgroundStyle: ViewModifier {
        
        var cornerRadius: CGFloat = 20
        var background: Color =  Color("glass-modal-background-1").opacity(0.6)
        
        var lineWidth: CGFloat = 1
        
        func body(content: Content) -> some View {
            
            content
                .background(
                    background
                )
                .mask {
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                }
                .modifier(GlassStyle.StrokeStyle(
                    shape: ShapeType.rectangle(cornerRadius: cornerRadius),
                    lineWidth: self.lineWidth,
                    colors: [
                        Color.white.opacity(0.5),
                        Color.black.opacity(0.1)
                    ])
                )
        }
    }
    
    struct ModalShadowStyle: ViewModifier {
        
        func body(content: Content) -> some View {
            
            content
                .modifier(DropShadowBaseStyle(topLeft: Color.white.opacity(0.2),
                                              topShadowRadius: 10,
                                              topShadowX: -5,
                                              topShadowY: -5,
                                              bottomRight: GlassStyle.shadowBottomColor.opacity(0.3),
                                              bottomShadowRadius: 10,
                                              bottomShadowX: 10,
                                              bottomShadowY: 10))
        }
    }
}

struct GlassModalBackgroundStyleGuide_Previews: PreviewProvider {
    static var previews: some View {
        GlassModalBackgroundStyleGuide()
            
    }
}
