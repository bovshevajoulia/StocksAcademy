//
//  GalaxyBackground.swift
//  StocksAcademy
//
//  Created by bovsheva on 25.07.2022.
//

import SwiftUI

extension GlassStyle {
    
    struct GalaxyBackground: View {
        
        var withPlanet: Bool = true
        
        init(addBigPlanet: Bool) {
            self.withPlanet = addBigPlanet
        }
        
        var body: some View {
            
            Group {
                if withPlanet {
                    content1
                }
                else {
                    content2
                }
            }
        }
        
        var content1: some View {
            ZStack {
                
                GlassStyle.backgroundGradient
                    .ignoresSafeArea()
                
                    .overlay(
                        
                        ZStack {
                            
                            stars1
                            
                            stars2
                            
                            stars3
                            
                            stars4
                            
                            stars5
                            
                            Blob1(size: 100)
                                .offset(x: 50, y: -150)
                            
                            Blob3(size: 50)
                                .blur(radius: 10)
                                .offset(x: -100, y: -100)
                            
                            Blob2(size: 480)
                                .offset(x: 200, y: 350)
                        }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    )
            }
        }
        
        var content2: some View {
            ZStack {
                
                GlassStyle.backgroundGradient
                    .ignoresSafeArea()
                
                    .overlay(
                        
                        ZStack {
                            
                            stars1
                            
                            stars2
                            
                            stars3
                            
                            stars4
                            
                            stars5
                            
                            Blob1(size: 100)
                                .offset(x: 50, y: -150)
                            
                            Blob3(size: 50)
                                .blur(radius: 10)
                                .offset(x: -100, y: -100)
                            
                        }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    )
            }
        }

        
        var stars1: some View {
            
            Group {
                
                Blob4(size: 4.0, blur: 1.0).offset(x: -87.77789277287039, y: 96.57792785503344)
                Blob4(size: 4.0, blur: 1.0).offset(x: 34.30189326608457, y: 304.37748932453434)
                Blob4(size: 4.0, blur: 1.0).offset(x: 38.27300457483063, y: -14.836024026299466)
                Blob4(size: 4.0, blur: 1.0).offset(x: -19.833495891367537, y: -279.4293336711083)
                Blob4(size: 4.0, blur: 1.0).offset(x: 119.70933905267435, y: 225.46047303812546)
                Blob4(size: 4.0, blur: 1.0).offset(x: 85.9651477688931, y: 201.68318622615286)
                Blob4(size: 4.0, blur: 1.0).offset(x: 47.75002238282631, y: 164.54138412712308)
                Blob4(size: 4.0, blur: 1.0).offset(x: -134.67024841478104, y: 176.56775443428225)
                Blob4(size: 4.0, blur: 1.0).offset(x: 102.38128419933985, y: -35.851454914106995)

            }
        }
        
        var stars2: some View {
            
            Group {
                Blob4(size: 4.0, blur: 1.0).offset(x: 74.3329848769565, y: 85.8591764242525)
                Blob4(size: 4.0, blur: 1.0).offset(x: 58.03623556366482, y: 92.68886432975006)
                Blob4(size: 4.0, blur: 1.0).offset(x: -15.412316844856688, y: -88.20446610363982)
                Blob4(size: 4.0, blur: 1.0).offset(x: 157.9129055216002, y: 270.0731344611139)
                Blob4(size: 4.0, blur: 1.0).offset(x: -121.84368554527023, y: 202.56956032422354)
                Blob4(size: 4.0, blur: 1.0).offset(x: -118.29906958723552, y: 216.05830534880423)
                Blob4(size: 4.0, blur: 1.0).offset(x: -50.19222165693098, y: -21.61662736411749)
                Blob4(size: 4.0, blur: 1.0).offset(x: 138.91234889144576, y: -273.6244723274911)
                Blob4(size: 4.0, blur: 1.0).offset(x: 119.2955021233543, y: -205.0959887343572)
            }
        }
        
        var stars3: some View {
            Group {
                Blob4(size: 5.0, blur: 1.25).offset(x: -53.38660119013976, y: -169.40865606423955)
                Blob4(size: 5.0, blur: 1.25).offset(x: -103.54536499690994, y: -262.9838300974865)
                Blob4(size: 5.0, blur: 1.25).offset(x: 26.603724896018967, y: 267.26619082659226)
                Blob4(size: 5.0, blur: 1.25).offset(x: 107.45002074109911, y: 144.58429261642402)
                Blob4(size: 5.0, blur: 1.25).offset(x: -50.833906841075915, y: -316.7341995427386)
                Blob4(size: 5.0, blur: 1.25).offset(x: -4.091614737963023, y: -64.2764213218411)
                Blob4(size: 5.0, blur: 1.25).offset(x: 133.87371811403005, y: -130.72640968086583)
                Blob4(size: 5.0, blur: 1.25).offset(x: 104.71235021890482, y: 124.36683537189622)
                Blob4(size: 5.0, blur: 1.25).offset(x: 112.4239991548246, y: -83.6139377907943)
            }
        }
        
        var stars4: some View {
            Group {
                Blob4(size: 6.0, blur: 1.5).offset(x: -108.65688417863375, y: -153.8555173604994)
                Blob4(size: 6.0, blur: 1.5).offset(x: 157.2833114737397, y: 203.97909216287547)
                Blob4(size: 6.0, blur: 1.5).offset(x: -93.23697532504896, y: -73.06547581634027)
                Blob4(size: 6.0, blur: 1.5).offset(x: 2.30228094859668, y: -101.61388397107132)
                Blob4(size: 6.0, blur: 1.5).offset(x: -106.32943395221331, y: -193.84030465249973)
                Blob4(size: 6.0, blur: 1.5).offset(x: -26.533140972066004, y: -262.96645315855784)
                Blob4(size: 6.0, blur: 1.5).offset(x: -3.796480219791154, y: -293.662197923142)
                Blob4(size: 6.0, blur: 1.5).offset(x: 10.825491871287918, y: -60.813615551103204)
                Blob4(size: 6.0, blur: 1.5).offset(x: 33.10897085318594, y: 312.61615334679556)
            }
        }
        
        var stars5: some View {
            Group {
                Blob4(size: 5.0, blur: 1.25).offset(x: 313.0199178357317, y: 338.37405745953106)
                Blob4(size: 5.0, blur: 1.25).offset(x: -176.05197479504463, y: 328.67467836241417)
                Blob4(size: 5.0, blur: 1.25).offset(x: 11.052648047345182, y: -6.720471434919051)
                Blob4(size: 5.0, blur: 1.25).offset(x: 60.17790261296794, y: 345.29628791976154)
                Blob4(size: 5.0, blur: 1.25).offset(x: 57.66369385671779, y: -160.33083272553884)
                Blob4(size: 5.0, blur: 1.25).offset(x: -57.712087022691264, y: -287.7970004303661)
                Blob4(size: 5.0, blur: 1.25).offset(x: -154.0063514838108, y: -274.5174924170766)
                Blob4(size: 5.0, blur: 1.25).offset(x: -263.63418349645775, y: -134.7227434544485)
                Blob4(size: 5.0, blur: 1.25).offset(x: 157.36491993828992, y: 89.99827946794892)
            }
        }
    }
}

struct GalaxyBackground_Previews: PreviewProvider {
    static var previews: some View {
        GlassStyle.GalaxyBackground(addBigPlanet: true)
            .preferredColorScheme(.dark)
    }
}
