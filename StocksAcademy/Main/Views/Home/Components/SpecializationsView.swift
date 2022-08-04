//
//  SpecializationsView.swift
//  StocksAcademy
//
//  Created by bovsheva on 17.07.2022.
//

import SwiftUI

struct SpecializationsView: View {
    
    @ObservedObject var viewModel: AcademyViewModel
    
    @EnvironmentObject var stateManager: StateManager
    
    var body: some View {
        
        TabView {
            
            ForEach(viewModel.specializations) { item in
                SpecializationCardView(item: item)
                    .padding(.top, 70)
                    .padding(.bottom, 45)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            viewModel.selectedSpecialization = item
                            stateManager.isSpecializationDetailPresented.toggle()
                        }
                    }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(height: 470)
    }
}

struct SpecializationsView_Previews: PreviewProvider {
    static var previews: some View {
        SpecializationsView(viewModel: AcademyViewModel(manager: StocksAcademyManager(),forPreview: true))
            .environmentObject(StateManager())
            .preferredColorScheme(.dark)
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}
