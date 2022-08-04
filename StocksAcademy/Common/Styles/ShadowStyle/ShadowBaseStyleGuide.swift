//
//  ShadowBaseStyleGuide.swift
//  StocksAcademy
//
//  Created by bovsheva on 16.07.2022.
//

import SwiftUI
import SwiftUI


struct ShadowBaseStyleGuide: View {
    
    var body: some View {
        
        VStack {
            
            Text("Button + shadows")
                .font(.system(.headline))
            
            Button {
                
            } label: {
                Text("Login")
            }
            .frame(width: 137, height: 52)
            .modifier(
                InnerShadowBaseStyle(
                    shape: ShapeType.rectangle(cornerRadius: 20),
                    backgroundLayer: Color.purple,
                    glowLayer: Color.white.opacity(0.5),
                    glowBlurRadius: 8,
                    glowOffsetX: -8,
                    glowOffsetY: -8,
                    foregroundLayerTopLeft: Color.purple.opacity(0.5),
                    foregroundLayerBottomRight: Color.purple,
                    foregroundBlurRadius: 4,
                    foregroundOffsetX: 0,
                    foregroundOffsetY: 0,
                    innerShadowVolume: 4
                )
            )
            .modifier(DropShadowBaseStyle(topLeft: Color.white.opacity(0.5),
                                          topShadowRadius: 10,
                                          topShadowX: -5,
                                          topShadowY: -5,
                                          bottomRight: Color.purple.opacity(0.5),
                                          bottomShadowRadius: 10,
                                          bottomShadowX: 5,
                                          bottomShadowY: 5)
            )
        }
    }
}

enum ShapeType {
    case oval
    case rectangle(cornerRadius: CGFloat)
    case circle
}

struct DropShadowBaseStyle: ViewModifier {
    
    let topLeft: Color
    let topShadowRadius: CGFloat
    let topShadowX: CGFloat
    let topShadowY: CGFloat
    
    let bottomRight: Color
    let bottomShadowRadius: CGFloat
    let bottomShadowX: CGFloat
    let bottomShadowY: CGFloat

    func body(content: Content) -> some View {
        content
            .shadow(color: bottomRight,
                    radius: bottomShadowRadius,
                    x: bottomShadowX,
                    y: bottomShadowY)
            .shadow(color: topLeft,
                    radius: topShadowRadius,
                    x: topShadowX,
                    y: topShadowY)
    }
}


struct InnerShadowBaseStyle: ViewModifier {
    
    let backgroundLayer: Color
    
    let glowLayer: Color
    
    let glowBlurRadius: CGFloat
    let glowOffsetX: CGFloat
    let glowOffsetY: CGFloat
    
    let foregroundLayerTopLeft: Color
    let foregroundLayerBottomRight: Color
    
    let foregroundBlurRadius: CGFloat
    let foregroundOffsetX: CGFloat
    let foregroundOffsetY: CGFloat

    let innerShadowVolume: CGFloat
    
    let shape: ShapeType
    
    init(shape: ShapeType,
         backgroundLayer: Color,
         
         glowLayer: Color = .white,
         glowBlurRadius: CGFloat,
         glowOffsetX: CGFloat,
         glowOffsetY: CGFloat,
    
         foregroundLayerTopLeft: Color,
         foregroundLayerBottomRight: Color,
         foregroundBlurRadius: CGFloat,
         foregroundOffsetX: CGFloat,
         foregroundOffsetY: CGFloat,

         innerShadowVolume: CGFloat
    ) {
        
        self.shape =  shape
        self.backgroundLayer = backgroundLayer
        self.glowLayer = glowLayer
        
        self.glowBlurRadius = glowBlurRadius
        self.glowOffsetX = glowOffsetX
        self.glowOffsetY = glowOffsetY

        self.foregroundLayerTopLeft = foregroundLayerTopLeft
        self.foregroundLayerBottomRight = foregroundLayerBottomRight
        self.foregroundBlurRadius = foregroundBlurRadius
        
        self.foregroundOffsetX = foregroundOffsetX
        self.foregroundOffsetY = foregroundOffsetY

        
        self.innerShadowVolume = innerShadowVolume
    }
    
    @ViewBuilder
    func makeCapsuleLayers() -> some View {
        
        Capsule()
            .foregroundColor(backgroundLayer)
        
        Capsule()
            .foregroundColor(glowLayer)
            
            .offset(x: glowOffsetX, y: glowOffsetY) // move the white layer to top left to add the volume
            .blur(radius: glowBlurRadius)
        
        Capsule()
            .fill(
                LinearGradient(colors: [foregroundLayerTopLeft, foregroundLayerBottomRight],
                               startPoint: UnitPoint.topLeading,
                               endPoint: UnitPoint.bottomTrailing)
            )
            .padding(innerShadowVolume) // like a volume Z size
            .blur(radius: foregroundBlurRadius)
    }
    
    @ViewBuilder
    func makeCircleLayers() -> some View {
        
        Circle()
            .foregroundColor(backgroundLayer)
        
        Circle()
            .foregroundColor(glowLayer)
            .blur(radius: glowBlurRadius)
            .offset(x: glowOffsetX, y: glowOffsetY) // move the white layer to top left to add the volume
        
        Circle()
            .fill(
                LinearGradient(colors: [foregroundLayerTopLeft, foregroundLayerBottomRight],
                               startPoint: UnitPoint.topLeading,
                               endPoint: UnitPoint.bottomTrailing)
            )
            .padding(innerShadowVolume) // like a volume Z size
            .blur(radius: foregroundBlurRadius)
    }
    
    @ViewBuilder
    func makeRectangleLayers(cornerRadius: CGFloat) -> some View {
        
        RoundedRectangle(
            cornerRadius: cornerRadius, style: RoundedCornerStyle.continuous)
            .foregroundColor(backgroundLayer)
        
        RoundedRectangle(
            cornerRadius: cornerRadius, style: RoundedCornerStyle.continuous)
            .foregroundColor(glowLayer)
            .offset(x: glowOffsetX, y: glowOffsetY) // move the white layer to top left to add the volume
            .blur(radius: glowBlurRadius)
        
        RoundedRectangle(cornerRadius: cornerRadius, style: RoundedCornerStyle.continuous)
            .fill(
                LinearGradient(colors: [foregroundLayerTopLeft, foregroundLayerBottomRight],
                               startPoint: UnitPoint.topLeading,
                               endPoint: UnitPoint.bottomTrailing)
            )
            .offset(x: foregroundOffsetX, y: foregroundOffsetY)
            .padding(innerShadowVolume) // like a volume Z size
            .blur(radius: foregroundBlurRadius)
    }
    
    @ViewBuilder
    func clipToShape(content: Content) -> some View {
        
        switch self.shape {
                
            case .oval:
                content.clipShape(Capsule())
                
            case .rectangle(let cornerRadius):
                
                content.clipShape(RoundedRectangle(cornerRadius: cornerRadius, style:RoundedCornerStyle.continuous))
                
            case .circle:
                content.clipShape(Circle())
        }
    }
    
    func body(content: Content) -> some View {
        
        switch self.shape {
                
            case .oval:
                
                content
                    .background(
                        ZStack {
                            self.makeCapsuleLayers()
                        }
                    )
                    .clipShape(Capsule())
                
            case .rectangle(let cornerRadius):
                
                content
                    .background(
                        ZStack {
                            self.makeRectangleLayers(cornerRadius: cornerRadius)
                        }
                    )
                    .clipShape(
                        RoundedRectangle(cornerRadius: cornerRadius,
                                         style: RoundedCornerStyle.continuous)
                    )
                
            case .circle:
                
                content
                    .background(
                        ZStack {
                            self.makeCircleLayers()
                        }
                    )
                    .clipShape(Circle())
                
        }
    }
}

struct ShadowBaseStyleGuide_Previews: PreviewProvider {
    static var previews: some View {
        ShadowBaseStyleGuide()
    }
}
