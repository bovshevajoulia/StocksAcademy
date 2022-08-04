//
//  SpecializationDetailView.swift
//  StocksAcademy
//
//  Created by bovsheva on 28.07.2022.
//

import SwiftUI

struct SpecializationDetailView: View {
    
    let item: StocksAcademy.SpecializationCardItem
    
    @ObservedObject var viewModel: AcademyViewModel
    
    @EnvironmentObject var stateManager: StateManager
    
    init(viewModel: AcademyViewModel) {
        self.viewModel = viewModel
        self.item = viewModel.selectedSpecialization!
    }
    
    var body: some View {
        
        ZStack(alignment: .top) {
            
            GlassStyle.background
                .ignoresSafeArea()
            
            background
                .ignoresSafeArea()
            
            ScrollView {
                content
                    .padding(.top, 200)
                
                coursesTitle
                
                CoursesListView(viewModel: viewModel)
                    .padding(.bottom, 75)
            }
            
            if stateManager.isCourseDetailPresented {
                CourseDetailView(viewModel: viewModel)
            }
            else {
                exitButton
            }
        }
    }
    
    var content: some View {
        
        VStack(alignment: .leading, spacing: 20) {
            
            title
            
            skills
            
            description
            
            VStack {
                HStack {
                    logo
                    
                    partner
                }
                estimatedTime
            }
        }
        .padding()
        .background(
            Rectangle()
                .fill(.ultraThinMaterial)
                .mask(
                    RoundedRectangle(cornerRadius: 30,
                                     style: .continuous)
                )
        )
        .padding()
    }
    
    var title: some View {
        GlassStyle.textGradient
            .frame(height: 120)
            .mask {
                Text(item.specialization.title)
                    .font(.title)
                    .bold()
                    .lineLimit(3)
            }
    }
    
    var estimatedTime: some View {
        Text(item.specialization.estimatedTime)
            .font(.footnote)
            .fontWeight(.semibold)
            .modifier(GlassStyle.TextColorStyle())
    }
    
    var description: some View {
        Text(item.specialization.description)
            .font(.footnote)
            .multilineTextAlignment(.leading)
            .modifier(GlassStyle.TextColorStyle())
    }
    
    var partner: some View {
        Text(item.specialization.partner)
            .font(.footnote)
            .modifier(GlassStyle.TextColorStyle())
    }
    
    var skills: some View {
        HStack(alignment: .top) {
            Text("Skills:")
                .font(.headline)
                .modifier(GlassStyle.TextColorStyle())
            
            Text(item.specialization.skills)
                .font(.caption2)
        }
    }
    
    var logo: some View {
        Image(item.specialization.partnerImage)
            .resizable()
            .modifier(GlassStyle.ImageIconStyle())
    }
    
    var coursesTitle: some View {
        Text("Courses")
            .font(.title.bold())
            .foregroundColor(.secondary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
    }
    
    var exitButton: some View {
        
        Button {
            withAnimation(.easeInOut(duration: 0.5)) {
                stateManager.isSpecializationDetailPresented.toggle()
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
            .ultraThinMaterial
        )
        .mask {
            RoundedRectangle(cornerRadius: 30,
                             style: .continuous)
        }
    }
}


struct SpecializationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SpecializationDetailView(viewModel: AcademyViewModel(manager: StocksAcademyManager(), forPreview: true))
            .environmentObject(StateManager())
    }
}
