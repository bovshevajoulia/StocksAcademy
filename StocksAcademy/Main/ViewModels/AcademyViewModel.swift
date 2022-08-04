//
//  AcademyViewModel.swift
//  StocksAcademy
//
//  Created by bovsheva on 24.07.2022.
//

import Foundation
import Combine


final class AcademyViewModel: ObservableObject {
    
    @Published var specializations: [StocksAcademy.SpecializationCardItem] = [StocksAcademy.SpecializationCardItem]()
    
    @Published var recentCourses: [StocksAcademy.CourseCardItem] = [StocksAcademy.CourseCardItem]()
    
    @Published var courses: [StocksAcademy.CourseCardItem] = [StocksAcademy.CourseCardItem]()
    
    @Published var modules: [StocksAcademy.Module] = [StocksAcademy.Module]()
    
    @Published var selectedSpecialization: StocksAcademy.SpecializationCardItem?  = nil
    
    @Published var selectedCourse: StocksAcademy.CourseCardItem? = nil
    
    
    // MARK: - Private
    private let manager: StocksAcademyManagerProtocol
    
    /// Set of an 'AnyCancellable' to store all subscriptions
    private var subscriptions = Set<AnyCancellable>()
    
    private let forPreview: Bool
    
    // MARK: - init
    init(manager: StocksAcademyManagerProtocol, forPreview: Bool = false) {
        self.manager = manager
        self.forPreview = forPreview
        print("AcademyViewModel: init")
        
        self.update()
    }
    
    public func update() {
        if forPreview == false {
            self.updateSpecializations()
            self.updateRecentCourses()
            self.setupSubscriptions()
        }
        else {
            self.specializations = StocksAcademy.dummySpecializations
            self.selectedSpecialization = StocksAcademy.dummySpecializations[0]
            self.courses = StocksAcademy.dummyCourses
            self.selectedCourse = StocksAcademy.dummyCourses[0]
            self.recentCourses = StocksAcademy.dummyCourses
            self.modules = StocksAcademy.financialMarketsModules()
        }
    }
    
    deinit {
        print("AcademyViewModel: deinit")
    }
    
    // MARK: - Private functions
    private func setupSubscriptions() {
        
        self.$selectedSpecialization
            .compactMap({ $0 })
            .sink { [unowned self] value in
                self.updateCourses(for: value.specialization.title)
            }
            .store(in: &subscriptions)
        
        self.$selectedCourse
            .compactMap({ $0 })
            .sink { [unowned self] value in
                self.updateModules(for: value.course.title)
            }
            .store(in: &subscriptions)
    }
    
    private func updateSpecializations() {
        
        self.manager.specializations()
            .receive(on: RunLoop.main)
            .map({ specializations -> [StocksAcademy.SpecializationCardItem] in
                return specializations.map { StocksAcademy.convert(from: $0) }
            })
            .assign(to: &$specializations)
    }
    
    private func updateRecentCourses() {
        self.manager.recentCourses()
            .receive(on: RunLoop.main)
            .map({ courses -> [StocksAcademy.CourseCardItem] in
                return courses.map { StocksAcademy.convert(from: $0) }
            })
            .assign(to: &$recentCourses)
    }
    
    private func updateCourses(for specialization: String) {
        
        self.manager.courses(for: specialization)
            .receive(on: RunLoop.main)
            .map({ courses -> [StocksAcademy.CourseCardItem] in
                return courses.map { StocksAcademy.convert(from: $0) }
            })
            .assign(to: &$courses)
    }
    
    private func updateModules(for course: String) {
        self.manager.modules(for: course)
            .receive(on: RunLoop.main)
            .assign(to: &$modules)
    }
}
