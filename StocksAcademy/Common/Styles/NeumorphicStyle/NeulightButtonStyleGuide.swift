//
//  NeulightButtonStyleGuide.swift
//  StocksAcademy
//
//  Created by bovsheva on 30.07.2022.
//

import SwiftUI

struct NeulightButtonStyleGuide: View {
    
    var palette: NeulightStyle.Palette
    
    var body: some View {
        
        Group {
            if palette == .purple {
                purpleContent
            }
            else {
                cyanContent
            }
        }
    }
    
    var purpleContent: some View {
        VStack(alignment: .center, spacing: 50) {
            
            Text("Neulight Buttons styles")
                .font(.system(.title))
            
            Text("Icon")
                .font(.system(.headline))
            
            HStack(spacing: 100) {
                Button {} label: {
                    Image(systemName: "house")
                }
                .buttonStyle(NeulightStyle.IconButtonStyle(palette: NeulightStyle.Palette.purple))
                
                Button {} label: {
                    Image(systemName: "house")
                }
                .buttonStyle(NeulightStyle.IconButtonStyle(palette: NeulightStyle.Palette.purple))
                .disabled(true)
            }
            
            Text("Icon circle")
                .font(.system(.headline))
            
            HStack(spacing: 100) {
                Button {} label: {
                    Image(systemName: "magnifyingglass")
                }
                .buttonStyle(NeulightStyle.IconCircleButtonStyle(palette: NeulightStyle.Palette.purple))
                
                Button {} label: {
                    Image(systemName: "magnifyingglass")
                }
                .buttonStyle(NeulightStyle.IconCircleButtonStyle(palette: NeulightStyle.Palette.purple))
                .disabled(true)
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(NeulightStyle.PalettePurple.background)
        .ignoresSafeArea(.all)

    }
    
    var cyanContent: some View {
        VStack(alignment: .center, spacing: 50) {
            
            Text("Neulight Buttons styles")
                .font(.system(.title))
            
            Text("Icon")
                .font(.system(.headline))
            
            HStack(spacing: 100) {
                Button {} label: {
                    Image(systemName: "house")
                }
                .buttonStyle(NeulightStyle.IconButtonStyle(palette: NeulightStyle.Palette.cyan))
                
                Button {} label: {
                    Image(systemName: "house")
                }
                .buttonStyle(NeulightStyle.IconButtonStyle(palette: NeulightStyle.Palette.cyan))
                .disabled(true)
            }
            
            Text("Icon circle")
                .font(.system(.headline))
            
            HStack(spacing: 100) {
                Button {} label: {
                    Image(systemName: "magnifyingglass")
                }
                .buttonStyle(NeulightStyle.IconCircleButtonStyle(palette: NeulightStyle.Palette.cyan))
                
                Button {} label: {
                    Image(systemName: "magnifyingglass")
                }
                .buttonStyle(NeulightStyle.IconCircleButtonStyle(palette: NeulightStyle.Palette.cyan))
                .disabled(true)
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(NeulightStyle.PaletteCyan.background)
        .ignoresSafeArea(.all)
    }
}

extension NeulightStyle {
    
    struct IconCircleButtonStyle: ButtonStyle {
        @Environment(\.colorScheme) var colorScheme
        @Environment(\.isEnabled) var isEnabled
        
        var palette: Palette
        
        var normalTopLeftColor: Color {
            switch self.palette {
                case .purple:
                    return NeulightStyle.PalettePurple.normalTopLeftColor
                case .cyan:
                    return NeulightStyle.PaletteCyan.normalTopLeftColor
            }
        }
        
        var normalBottomRightColor: Color {
            switch self.palette {
                case .purple:
                    return NeulightStyle.PalettePurple.normalBottomRightColor
                case .cyan:
                    return NeulightStyle.PaletteCyan.normalBottomRightColor
            }
        }
        
        var backgroundColorTopLeft: Color {
            isEnabled ? normalTopLeftColor : NeulightStyle.disableTopLeftColor
        }
        
        var backgroundColorBottomRight: Color {
            isEnabled ? normalBottomRightColor : NeulightStyle.disableBottomRightColor
        }
        
        var textColor: Color {
            isEnabled ? Color.black.opacity(0.5) : Color.gray.opacity(0.5)
        }
        
        var size: CGFloat
        
        init(size: CGFloat = 44, palette: Palette) {
            self.size = size
            self.palette = palette
        }
        
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .font(.system(size: self.size / 3))
                .foregroundColor(textColor)
                .padding(self.size / 4)
                .frame(width: self.size, height: self.size)
                .modifier(
                    InnerShadowBaseStyle(
                        shape: ShapeType.circle,
                        backgroundLayer: self.backgroundColorTopLeft,
                        glowLayer: Color.white,
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
                .modifier(DropShadowBaseStyle(topLeft: Color.white,
                                              topShadowRadius: 8,
                                              topShadowX: -8,
                                              topShadowY: -8,
                                              bottomRight: self.backgroundColorTopLeft,
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
                    return NeulightStyle.PalettePurple.normalTopLeftColor
                case .cyan:
                    return NeulightStyle.PaletteCyan.normalTopLeftColor
            }
        }
        
        var normalBottomRightColor: Color {
            switch self.palette {
                case .purple:
                    return NeulightStyle.PalettePurple.normalBottomRightColor
                case .cyan:
                    return NeulightStyle.PaletteCyan.normalBottomRightColor
            }
        }
        
        var backgroundColorTopLeft: Color {
            isEnabled ? normalTopLeftColor : NeulightStyle.disableTopLeftColor
        }
        
        var backgroundColorBottomRight: Color {
            isEnabled ? normalBottomRightColor : NeulightStyle.disableBottomRightColor
        }
        
        var textColor: Color {
            isEnabled ? Color.black.opacity(0.5) : Color.gray.opacity(0.5)
        }
        
        var size: CGFloat
        
        init(size: CGFloat = 44, palette: Palette) {
            self.size = size
            self.palette = palette
        }
        
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .font(.system(size: self.size / 3))
                .foregroundColor(textColor)
                .padding(self.size / 4)
                .frame(width: self.size, height: self.size)
                .modifier(
                    InnerShadowBaseStyle(
                        shape: ShapeType.rectangle(cornerRadius: self.size / 4),
                        backgroundLayer: self.backgroundColorTopLeft,
                        glowLayer: Color.white,
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
                .modifier(DropShadowBaseStyle(topLeft: Color.white,
                                              topShadowRadius: 8,
                                              topShadowX: -8,
                                              topShadowY: -8,
                                              bottomRight: self.backgroundColorTopLeft,
                                              bottomShadowRadius: 10,
                                              bottomShadowX: 8,
                                              bottomShadowY: 8)
                )
                .scaleEffect(configuration.isPressed ? 0.85 : 1)
                .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
        }
    }
    
}

struct NeulightButtonStyleGuide_Previews: PreviewProvider {
    static var previews: some View {
        NeulightButtonStyleGuide(palette: NeulightStyle.Palette.cyan)
    }
}
