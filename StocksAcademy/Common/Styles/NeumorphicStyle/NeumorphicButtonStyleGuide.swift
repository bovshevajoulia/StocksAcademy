//
//  NeumorphicButtonStyleGuide.swift
//  StocksAcademy
//
//  Created by bovsheva on 16.07.2022.
//

import SwiftUI

struct NeumorphicButtonStyleGuide: View {
    var body: some View {
        
        VStack(spacing: 50) {
            
            Text("Neumorphic Button styles")
                .font(.title)
            
            Button {
                
            } label: {
                Text("Login")
            }
            .frame(width: 137, height: 52)
            .buttonStyle(NeumorphicStyle.PrimaryButtonStyle())
            
            Button {
                
            } label: {
                Text("Login")
            }
            .frame(width: 137, height: 52)
            .buttonStyle(NeumorphicStyle.PaletteButtonStyle(palette: .cyan))
            
            Button {
                
            } label: {
                Text("Login")
            }
            .frame(width: 137, height: 52)
            .buttonStyle(NeumorphicStyle.PaletteButtonStyle(palette: .purple))
            
            HStack(spacing: 100) {
                Button {} label: {
                    Image(systemName: "house")
                }
                .buttonStyle(NeumorphicStyle.IconButtonStyle(palette: NeumorphicStyle.Palette.purple))
                
                Button {} label: {
                    Image(systemName: "house")
                }
                .buttonStyle(NeumorphicStyle.IconButtonStyle(palette: NeumorphicStyle.Palette.purple))
                .disabled(true)
            }
            
            HStack(spacing: 100) {
                Button {} label: {
                    Image(systemName: "magnifyingglass")
                }
                .buttonStyle(NeumorphicStyle.IconCircleButtonStyle(palette: NeumorphicStyle.Palette.purple))
                
                Button {} label: {
                    Image(systemName: "magnifyingglass")
                }
                .buttonStyle(NeumorphicStyle.IconCircleButtonStyle(palette: NeumorphicStyle.Palette.purple))
                .disabled(true)
            }
        }
    }
}

extension NeumorphicStyle {
    
    enum Palette {
        case purple
        case cyan
    }
    
    struct PrimaryButtonStyle: ButtonStyle {
        @Environment(\.colorScheme) var colorScheme
        @Environment(\.isEnabled) var isEnabled
        
        var backgroundTopColor: Color {
            isEnabled ? NeumorphicStyle.buttonNormalTopColor : NeumorphicStyle.buttonDisableTopColor
        }
        
        var backgroundBottomColor: Color {
            isEnabled ? NeumorphicStyle.buttonNormalBottomColor : NeumorphicStyle.buttonDisableBottomColor
        }
        
        var textColor: Color {
            isEnabled ? Color.white : Color.gray
        }
        
        func makeBody(configuration: Configuration) -> some View {
            
            configuration.label
                .font(.body)
                .foregroundColor(self.textColor)
                .padding(15)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .modifier(
                    InnerShadowBaseStyle(
                        shape: ShapeType.rectangle(cornerRadius: 20),
                        backgroundLayer: self.backgroundBottomColor,
                        glowLayer: colorScheme == .dark ? Color.white.opacity(0.3) : Color.white.opacity(0.5),
                        glowBlurRadius: 8,
                        glowOffsetX: -8,
                        glowOffsetY: -8,
                        foregroundLayerTopLeft: self.backgroundTopColor,
                        foregroundLayerBottomRight: self.backgroundBottomColor,
                        foregroundBlurRadius: 4,
                        foregroundOffsetX: 0,
                        foregroundOffsetY: 0,
                        innerShadowVolume: 3
                    )
                )
                .modifier(DropShadowBaseStyle(topLeft: colorScheme == .dark ? Color.white.opacity(0.3) : Color.white.opacity(0.5),
                                              topShadowRadius: 10,
                                              topShadowX: -8,
                                              topShadowY: -8,
                                              bottomRight: self.backgroundBottomColor.opacity(0.5),
                                              bottomShadowRadius: 10,
                                              bottomShadowX: 8,
                                              bottomShadowY: 8)
                )
                .scaleEffect(configuration.isPressed ? 0.95 : 1)
                .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
        }
        
    }
    
    struct PaletteButtonStyle: ButtonStyle {
        @Environment(\.colorScheme) var colorScheme
        @Environment(\.isEnabled) var isEnabled
        
        var normalTopColor: Color {
            switch self.palette {
                case .purple:
                    return NeumorphicStyle.PalettePurple.buttonNormalTopColor
                case .cyan:
                    return NeumorphicStyle.PaletteCyan.buttonNormalTopColor
            }
        }
        
        var normalBottomColor: Color {
            switch self.palette {
                case .purple:
                    return NeumorphicStyle.PalettePurple.buttonNormalBottomColor
                case .cyan:
                    return NeumorphicStyle.PaletteCyan.buttonNormalBottomColor
            }
        }
        
        var backgroundTopColor: Color {
            isEnabled ? self.normalTopColor : NeumorphicStyle.buttonDisableTopColor
        }
        
        var backgroundBottomColor: Color {
            isEnabled ? self.normalBottomColor : NeumorphicStyle.buttonDisableBottomColor
        }
        
        var labelTextColor: Color {
            switch self.palette {
                case .purple:
                    return NeumorphicStyle.PalettePurple.textColor
                case .cyan:
                    return NeumorphicStyle.PaletteCyan.textColor
            }
        }
        
        var textColor: Color {
            isEnabled ? self.labelTextColor : Color.gray
        }
        
        let palette: Palette
        
        init(palette: Palette) {
            self.palette = palette
        }
        
        func makeBody(configuration: Configuration) -> some View {
            
            configuration.label
                .font(.body)
                .foregroundColor(self.textColor)
                .padding(15)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .modifier(
                    InnerShadowBaseStyle(
                        shape: ShapeType.rectangle(cornerRadius: 20),
                        backgroundLayer: self.backgroundBottomColor,
                        glowLayer: colorScheme == .dark ? Color.white.opacity(0.3) : Color.white.opacity(0.5),
                        glowBlurRadius: 8,
                        glowOffsetX: -8,
                        glowOffsetY: -8,
                        foregroundLayerTopLeft: self.backgroundTopColor,
                        foregroundLayerBottomRight: self.backgroundBottomColor,
                        foregroundBlurRadius: 4,
                        foregroundOffsetX: 0,
                        foregroundOffsetY: 0,
                        innerShadowVolume: 3
                    )
                )
                .modifier(DropShadowBaseStyle(topLeft: colorScheme == .dark ? Color.white.opacity(0.3) : Color.white.opacity(0.5),
                                              topShadowRadius: 10,
                                              topShadowX: -8,
                                              topShadowY: -8,
                                              bottomRight: self.backgroundBottomColor.opacity(0.5),
                                              bottomShadowRadius: 10,
                                              bottomShadowX: 8,
                                              bottomShadowY: 8)
                )
                .scaleEffect(configuration.isPressed ? 0.95 : 1)
                .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
        }
    }
    
    struct IconCircleButtonStyle: ButtonStyle {
        @Environment(\.colorScheme) var colorScheme
        @Environment(\.isEnabled) var isEnabled
        
        var palette: Palette
        
        var normalTopLeftColor: Color {
            switch self.palette {
                case .purple:
                    return NeumorphicStyle.PalettePurple.buttonNormalTopColor
                case .cyan:
                    return NeumorphicStyle.PaletteCyan.buttonNormalTopColor
            }
        }
        
        var normalBottomRightColor: Color {
            switch self.palette {
                case .purple:
                    return NeumorphicStyle.PalettePurple.buttonNormalBottomColor
                case .cyan:
                    return NeumorphicStyle.PaletteCyan.buttonNormalBottomColor
            }
        }
        
        var backgroundColorTopLeft: Color {
            isEnabled ? normalTopLeftColor : NeumorphicStyle.buttonDisableTopColor
        }
        
        var backgroundColorBottomRight: Color {
            isEnabled ? normalBottomRightColor : NeumorphicStyle.buttonDisableBottomColor
        }
        
        var labelTextColor: Color {
            switch self.palette {
                case .purple:
                    return NeumorphicStyle.PalettePurple.textColor
                case .cyan:
                    return NeumorphicStyle.PaletteCyan.textColor
            }
        }
        
        var textColor: Color {
            isEnabled ? self.labelTextColor : Color.gray
        }
        
        var size: CGFloat
        
        init(size: CGFloat = 44, palette: Palette) {
            self.size = size
            self.palette = palette
        }
        
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .font(.system(size: self.size / 3))
                .foregroundColor(self.labelTextColor)
                .padding(self.size / 4)
                .frame(width: self.size, height: self.size)
                .modifier(
                    InnerShadowBaseStyle(
                        shape: ShapeType.circle,
                        backgroundLayer: self.backgroundColorBottomRight,
                        glowLayer: colorScheme == .dark ? Color.white.opacity(0.3) : Color.white.opacity(0.5),
                        glowBlurRadius: 8,
                        glowOffsetX: -8,
                        glowOffsetY: -8,
                        foregroundLayerTopLeft: self.backgroundColorTopLeft,
                        foregroundLayerBottomRight: self.backgroundColorBottomRight,
                        foregroundBlurRadius: 4,
                        foregroundOffsetX: 0,
                        foregroundOffsetY: 0,
                        innerShadowVolume: 3
                    )
                )
                .modifier(DropShadowBaseStyle(topLeft: colorScheme == .dark ? Color.white.opacity(0.3) : Color.white.opacity(0.5),
                                              topShadowRadius: 10,
                                              topShadowX: -8,
                                              topShadowY: -8,
                                              bottomRight: self.backgroundColorBottomRight.opacity(0.5),
                                              bottomShadowRadius: 10,
                                              bottomShadowX: 8,
                                              bottomShadowY: 8)
                )

                .scaleEffect(configuration.isPressed ? 0.85 : 1)
                .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
        }
    }
    
    
    struct IconButtonStyle: ButtonStyle {
        @Environment(\.colorScheme) var colorScheme
        @Environment(\.isEnabled) var isEnabled
        
        var palette: Palette
        
        var normalTopLeftColor: Color {
            switch self.palette {
                case .purple:
                    return NeumorphicStyle.PalettePurple.buttonNormalTopColor
                case .cyan:
                    return NeumorphicStyle.PaletteCyan.buttonNormalTopColor
            }
        }
        
        var normalBottomRightColor: Color {
            switch self.palette {
                case .purple:
                    return NeumorphicStyle.PalettePurple.buttonNormalBottomColor
                case .cyan:
                    return NeumorphicStyle.PaletteCyan.buttonNormalBottomColor
            }
        }
        
        var backgroundColorTopLeft: Color {
            isEnabled ? normalTopLeftColor : NeumorphicStyle.buttonDisableTopColor
        }
        
        var backgroundColorBottomRight: Color {
            isEnabled ? normalBottomRightColor : NeumorphicStyle.buttonDisableBottomColor
        }
        
        var labelTextColor: Color {
            switch self.palette {
                case .purple:
                    return NeumorphicStyle.PalettePurple.textColor
                case .cyan:
                    return NeumorphicStyle.PaletteCyan.textColor
            }
        }
        
        var textColor: Color {
            isEnabled ? self.labelTextColor : Color.gray
        }
        
        var size: CGFloat
        
        init(size: CGFloat = 44, palette: Palette) {
            self.size = size
            self.palette = palette
        }
        
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .font(.system(size: self.size / 3))
                .foregroundColor(self.labelTextColor)
                .padding(self.size / 4)
                .frame(width: self.size, height: self.size)
                .modifier(
                    InnerShadowBaseStyle(
                        shape: ShapeType.rectangle(cornerRadius: self.size / 4),
                        backgroundLayer: self.backgroundColorBottomRight,
                        glowLayer: colorScheme == .dark ? Color.white.opacity(0.3) : Color.white.opacity(0.5),
                        glowBlurRadius: 8,
                        glowOffsetX: -8,
                        glowOffsetY: -8,
                        foregroundLayerTopLeft: self.backgroundColorTopLeft,
                        foregroundLayerBottomRight: self.backgroundColorBottomRight,
                        foregroundBlurRadius: 4,
                        foregroundOffsetX: 0,
                        foregroundOffsetY: 0,
                        innerShadowVolume: 3
                    )
                )
                .modifier(DropShadowBaseStyle(topLeft: colorScheme == .dark ? Color.white.opacity(0.3) : Color.white.opacity(0.5),
                                              topShadowRadius: 10,
                                              topShadowX: -8,
                                              topShadowY: -8,
                                              bottomRight: self.backgroundColorBottomRight.opacity(0.5),
                                              bottomShadowRadius: 10,
                                              bottomShadowX: 8,
                                              bottomShadowY: 8)
                )
                .scaleEffect(configuration.isPressed ? 0.85 : 1)
                .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
        }
    }
    
}


struct NeumorphicButtonStyleGuide_Previews: PreviewProvider {
    static var previews: some View {
        NeumorphicButtonStyleGuide()
            .preferredColorScheme(.dark)
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}
