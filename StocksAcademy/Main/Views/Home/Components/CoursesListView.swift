//
//  CoursesListView.swift
//  StocksAcademy
//
//  Created by bovsheva on 30.07.2022.
//

import SwiftUI


struct CoursesListView: View {
    
    @ObservedObject var viewModel: AcademyViewModel
    
    @EnvironmentObject var stateManager: StateManager
    
    var body: some View {
        
        LazyVStack {
            
            ForEach(viewModel.courses) { item in
                
                CourseListItemView(item: item)
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

struct CoursesListView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesListView(viewModel: AcademyViewModel(manager: StocksAcademyManager(), forPreview: true))
            .environmentObject(StateManager())
    }
}
