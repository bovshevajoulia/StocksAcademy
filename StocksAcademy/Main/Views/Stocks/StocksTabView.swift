//
//  StocksTabView.swift
//  StocksAcademy
//
//  Created by bovsheva on 17.07.2022.
//

import SwiftUI

struct StocksTabView: View {
    
    @ObservedObject var viewModel: StocksViewModel
    
    @EnvironmentObject var stateManager: StateManager
    
    var body: some View {
        
        ScrollView {
            
            StocksCardListView(items: $viewModel.stockSymbolItems)
                .detectScrolling(in: stateManager.scrollNamespace,
                                 hasScrolled: $stateManager.hasScrolled)
        }
        .coordinateSpace(name: stateManager.scrollNamespace)
        .background(
            Image("background-image")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
        )
        .onAppear {
            viewModel.update()
        }
    }
}

struct StocksTabView_Previews: PreviewProvider {
    static var previews: some View {
        StocksTabView(viewModel: StocksViewModel(manager: StocksManager(),
                                                 forPreview: true))
            .environmentObject(StateManager())
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}
