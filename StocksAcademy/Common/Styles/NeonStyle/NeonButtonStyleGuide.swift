//
//  GlassButtonStyleGuide.swift
//  StocksAcademy
//
//  Created by bovsheva on 16.07.2022.
//

import SwiftUI

struct NeonButtonStyleGuide: View {
    
    var body: some View {
        
        VStack(spacing: 40) {
            
            Text("Neon Primary button style")
                .font(.title)
            
            Button {
                
            } label: {
                Text("Login")
            }
            .frame(width: 137, height: 52)
            .buttonStyle(NeonStyle.PrimaryButtonStyle(cornerRadius: 16))
            
            Button {
                
            } label: {
                Text("Login")
            }
            .frame(width: 137, height: 52)
            .buttonStyle(NeonStyle.PrimaryButtonStyle(cornerRadius: 16))
            .disabled(true)
            
            Text("Neon Icon button style")
                .font(.title)
            
            Button {} label: {
                Image(systemName: "magnifyingglass")
            }
            .buttonStyle(NeonStyle.IconButtonStyle(size: 36))
            
            
            Button {} label: {
                Image(systemName: "magnifyingglass")
            }
            .buttonStyle(NeonStyle.CircleButtonStyle(size: 36))
            
            Button {} label: {
                Image(systemName: "house")
            }
            .buttonStyle(NeonStyle.TabbarButtonStyle(size: 36,
                                                     isSelected: true))
        }
    }
}

extension NeonStyle {
    
    struct PrimaryButtonStyle: ButtonStyle {
        
        @Environment(\.isEnabled) var isEnabled
        @Environment(\.colorScheme) var colorScheme
        
        var primaryTextColor: Color {
            colorScheme == .dark ? Color.white.opacity(0.8) : Color.black.opacity(0.7)
        }
        
        var textColor: Color {
            isEnabled ? self.primaryTextColor : Color.gray
        }
        
        var colors: [Color] {
            isEnabled ? [
                NeonStyle.strokeGradient1,
                NeonStyle.strokeGradient2,
                NeonStyle.strokeGradient3,
                NeonStyle.strokeGradient4
            ] :
            [
                Color.gray.opacity(0.8),
                Color.gray.opacity(0.5),
                Color.gray.opacity(0.3)
            ]
        }
        
        let cornerRadius: CGFloat
        
        init(cornerRadius: CGFloat) {
            self.cornerRadius = cornerRadius
        }
        
        func makeBody(configuration: Configuration) -> some View {
            
            configuration.label
                .font(.body)
                .foregroundColor(self.textColor)
                .padding(15)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(NeonStyle.buttonBackground.opacity(0.85),
                            in: RoundedRectangle(cornerRadius: cornerRadius,
                                                 style: .continuous)
                )
                .modifier(
                    NeonStyle.GradientStrokeStyle(lineWidth: 2, shape: ShapeType.rectangle(cornerRadius: self.cornerRadius), colors: self.colors)
                )
                .scaleEffect(configuration.isPressed ? 0.95 : 1)
                .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
        }
    }

    struct IconButtonStyle: ButtonStyle {
        
        @Environment(\.isEnabled) var isEnabled
        @Environment(\.colorScheme) var colorScheme
        
        var primaryTextColor: Color {
            colorScheme == .dark ? Color.white.opacity(0.8) : Color.black.opacity(0.7)
        }
        
        var textColor: Color {
            isEnabled ? self.primaryTextColor : Color.gray
        }
        
        let size: CGFloat
        
        var cornerRadius: CGFloat {
            size / 4
        }
        
        init(size: CGFloat) {
            self.size = size
        }
        
        func makeBody(configuration: Configuration) -> some View {
            
            configuration.label
                .font(.body)
                .foregroundColor(self.textColor)
                .padding(15)
                .frame(width: size, height: size)
                .background(.ultraThinMaterial,
                            in: RoundedRectangle(cornerRadius: cornerRadius,
                                                 style: .continuous)
                )
                .modifier(NeonStyle.GradientStrokeStyle(lineWidth: 2, shape: ShapeType.rectangle(cornerRadius: self.cornerRadius)))
                
                .scaleEffect(configuration.isPressed ? 0.95 : 1)
                .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
        }
    }
    
    struct CircleButtonStyle: ButtonStyle {
        
        @Environment(\.isEnabled) var isEnabled
        @Environment(\.colorScheme) var colorScheme
        
        var primaryTextColor: Color {
            colorScheme == .dark ? Color.white.opacity(0.8) : Color.black.opacity(0.7)
        }
        
        var textColor: Color {
            isEnabled ? self.primaryTextColor : Color.gray
        }
        
        let size: CGFloat
        
        init(size: CGFloat) {
            self.size = size
        }
        
        func makeBody(configuration: Configuration) -> some View {
            
            configuration.label
                .font(.body)
                .foregroundColor(self.textColor)
                .padding(15)
                .background(.ultraThinMaterial,
                            in: Circle()
                )
                .modifier(NeonStyle.GradientStrokeStyle(lineWidth: 2, shape: ShapeType.circle))
                .frame(width: size, height: size)
                .scaleEffect(configuration.isPressed ? 0.95 : 1)
                .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
        }
    }
    
    struct TabbarButtonStyle: ButtonStyle {
        
        @Environment(\.colorScheme) var colorScheme
        
        var size: CGFloat
        var isSelected: Bool
        
        func makeBody(configuration: Configuration) -> some View {
            
            configuration.label
                .font(.system(size: 25,
                              weight: .regular,
                              design: .default))
                .foregroundColor(self.isSelected ? NeonStyle.tabbarSelected : NeonStyle.tabbarNormal)
                .frame(width: self.size, height: self.size)
                .padding()
                .modifier(NeonStyle.LightEffectStyle(width: size,
                                                     heith: size,
                                                     isLighted: self.isSelected))
        }
    }
}

struct NeonButtonStyleGuide_Previews: PreviewProvider {
    static var previews: some View {
        NeonButtonStyleGuide()
            .preferredColorScheme(.dark)
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}
