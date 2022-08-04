//
//  MainView.swift
//  StocksAcademy
//
//  Created by bovsheva on 15.07.2022.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var homeViewModel: AcademyViewModel
    @ObservedObject var stocksViewModel: StocksViewModel
    @ObservedObject var marketNewsViewModel: MarketNewsViewModel
    
    @ObservedObject var stateManager = StateManager()
    
    var body: some View {
        
        ZStack {
            
            ZStack {
                
                switch stateManager.tabSelection {
                    
                    case 0:
                        HomeView(viewModel: homeViewModel)
                    
                    case 1:
                        
                        StocksTabView(viewModel: stocksViewModel)
                        
                    case 3:
                        
                        MarketNewsTabView(viewModel: marketNewsViewModel)
                    
                    case 4:
                        StylesGuideView()
                        
                    default:
                        VStack {
                            Text("Default screen")
                        }
                }
                
                if stateManager.isSingInModalPresented {
                    
                    ZStack {
                        
                        GlassStyle.background.opacity(0.85)
                            .blur(radius: 30)
                            .ignoresSafeArea()
                        
                        SingInView()
                    }
                }
            }
            .safeAreaInset(edge: VerticalEdge.top) {
                Color.clear
                    .frame(height: 70)
            }
            .overlay(
                ZStack {
                    if stateManager.isNavigationBarPresented {
                        NavigationBarView()
                    }
                }
            )
            .overlay(
                StocksAcademy.TabbarView(selection: $stateManager.tabSelection)
            )
            .environmentObject(stateManager)
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static let manager = StocksManager()
    static let state = StateManager()
    
    static var previews: some View {
        
        MainView(homeViewModel: AcademyViewModel(manager: StocksAcademyManager(),
                                                 forPreview: true),
                 
                 stocksViewModel: StocksViewModel(manager: self.manager,
                                                  forPreview: true),
                 
                 marketNewsViewModel: MarketNewsViewModel(manager: self.manager,
                                                          forPreview: true),
                 stateManager: state)
            .environmentObject(state)
            .preferredColorScheme(.dark)
    }
}
