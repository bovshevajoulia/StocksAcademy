//
//  HomeView.swift
//  StocksAcademy
//
//  Created by bovsheva on 17.07.2022.
//

import SwiftUI


struct HomeView: View {
    
    // we get the VM from the Coordinator
    @ObservedObject var viewModel: AcademyViewModel
    
    @EnvironmentObject var stateManager: StateManager
    
    var body: some View {
        
        ZStack {
            
            GlassStyle.GalaxyBackground(addBigPlanet: true)
                .ignoresSafeArea()
            
            ScrollView {
                
                if stateManager.isSpecializationDetailPresented == false {
                    SpecializationsView(viewModel: viewModel)
                        .detectScrolling(in: stateManager.scrollNamespace,
                                         hasScrolled: $stateManager.hasScrolled)
                }
                
                coursesTitle
                
                if stateManager.isCourseDetailPresented == false {
                    recentCoursesList
                }
            }
            .coordinateSpace(name: stateManager.scrollNamespace)
            
            if stateManager.isCourseDetailPresented {
                CourseDetailView(viewModel: viewModel)
            }
            
            if stateManager.isSpecializationDetailPresented {
                SpecializationDetailView(viewModel: viewModel)
            }
        }
    }
    
    var coursesTitle: some View {
        Text("Recent courses")
            .font(.title.bold())
            .modifier(GlassStyle.TextColorStyle())
            .frame(maxWidth: .infinity,
                   alignment: .leading)
            .padding(.horizontal, 20)
    }
    
    var recentCoursesList: some View {
        LazyVStack {
            
            ForEach(viewModel.recentCourses) { item in
                
                CourseCardView(item: item)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            viewModel.selectedCourse = item
                            stateManager.isCourseDetailPresented.toggle()
                        }
                    }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: AcademyViewModel(manager: StocksAcademyManager()))
            .environmentObject(StateManager())
            .preferredColorScheme(.dark)
    }
}
