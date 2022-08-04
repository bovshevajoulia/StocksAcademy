//
//  CourseDetailView.swift
//  StocksAcademy
//
//  Created by bovsheva on 19.07.2022.
//

import SwiftUI

struct CourseDetailView: View {
    
    let item: StocksAcademy.CourseCardItem
    
    @ObservedObject var viewModel: AcademyViewModel
    
    @EnvironmentObject var stateManager: StateManager
    
    init(viewModel: AcademyViewModel) {
        self.viewModel = viewModel
        self.item = viewModel.selectedCourse!
    }

    var body: some View {
        
        ZStack(alignment: .top) {
            
            GlassStyle.background
                .ignoresSafeArea()
            
            background
                .ignoresSafeArea()
            
            ScrollView {
                content
                    .padding(.top, 250)
                    .padding(.bottom, 75)
            }
            .ignoresSafeArea()
            
            exitButton
        }
    }
    
    var exitButton: some View {
        
        Button {
            withAnimation(.easeInOut(duration: 0.5)) {
                stateManager.isCourseDetailPresented.toggle()
            }
        } label: {
            Image(systemName: "xmark")
        }
        .buttonStyle(GlassStyle.XButtonStyle())
    }
    
    var background: some View {
        
        VStack {
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 400)
        .background(
            item.image
                .resizable()
                .aspectRatio(contentMode: .fit)
        )
        .background(
            item.background
        )
        .mask {
            RoundedRectangle(cornerRadius: 30,
                             style: .continuous)
        }
    }
    
    var content: some View {
        
        VStack {
            
            VStack(alignment: .leading, spacing: 12) {
                
                title
                
                estimatedTime
                
                description
            }
            .modifier(GlassStyle.TextColorStyle())
            .padding(20)
            .background(
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .mask(
                        RoundedRectangle(cornerRadius: 30,
                                         style: .continuous)
                    )
            )
            
            modulesTitle
            
            ModulesListView(viewModel: viewModel)
            
        }
        .padding(20)
    }
    
    var modulesTitle: some View {
        Text("Modules")
            .font(.title.bold())
            .foregroundColor(.secondary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
    }
    
    var title: some View {
        Text(item.course.title)
            .font(.title.bold())
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var estimatedTime: some View {
        Text(item.course.estimatedTime)
            .font(.footnote.weight(.semibold))
    }
    
    var description: some View {
        Text(item.course.shortDescription)
            .lineLimit(3)
            .font(.footnote)
    }
}

struct CourseDetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        CourseDetailView(viewModel: AcademyViewModel(manager: StocksAcademyManager(),
                                                     forPreview: true))
            .environmentObject(StateManager())
            .preferredColorScheme(.dark)
    }
}
