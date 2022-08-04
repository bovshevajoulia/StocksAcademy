//
//  MarketNewsTabView.swift
//  StocksAcademy
//
//  Created by bovsheva on 27.07.2022.
//

import SwiftUI

struct MarketNewsTabView: View {
    
    @ObservedObject var viewModel: MarketNewsViewModel
    
    @EnvironmentObject var stateManager: StateManager
    
    var body: some View {
        
        ZStack {
            
            GlassStyle.GalaxyBackground(addBigPlanet: true)
                .ignoresSafeArea()
            
            ScrollView {
                
                ForEach(viewModel.stockNewsStories) { item in
                    NewsLisItem(item: item)
                }
                .detectScrolling(in: stateManager.scrollNamespace,
                                 hasScrolled: $stateManager.hasScrolled)
            }
            .coordinateSpace(name: stateManager.scrollNamespace)
            
            if viewModel.isLoading {
                ProgressView()
            }
            
            if viewModel.errorMessage.isEmpty == false {
                MarketNewsErrorView(error: $viewModel.errorMessage,
                                    tryAgain: $viewModel.reload)
            }
        }
        .onAppear {
            viewModel.update()
        }
    }
}

struct MarketNewsView_Previews: PreviewProvider {
    static var previews: some View {
        
        MarketNewsTabView(viewModel: MarketNewsViewModel(manager: StocksManager(), forPreview: true))
            .environmentObject(StateManager())
    }
}
