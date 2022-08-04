//
//  ModulesListView.swift
//  StocksAcademy
//
//  Created by bovsheva on 31.07.2022.
//

import SwiftUI


struct ModulesListView: View {
    
    @ObservedObject var viewModel: AcademyViewModel
    
    @EnvironmentObject var stateManager: StateManager
    
    var body: some View {
        VStack(spacing: 8) {
            ForEach(viewModel.modules.indices, id: \.self) { index in
                ModuleListItemView(item: viewModel.modules[index])
            }
        }
    }
}

struct ModulesListView_Previews: PreviewProvider {
    static var previews: some View {
        ModulesListView(viewModel: AcademyViewModel(manager: StocksAcademyManager(), forPreview: true))
            .environmentObject(StateManager())
    }
}
