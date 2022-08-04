//
//  StateManager.swift
//  StocksAcademy
//
//  Created by bovsheva on 28.07.2022.
//

import Foundation
import Combine

/// Object to store Main module state
class StateManager: ObservableObject {
    
    @Published var tabSelection: Int = 0
    @Published var tabPlusTapped: Bool = false
    
    /// Navigation showing mode
    @Published var isNavigationBarPresented: Bool = true
    
    /// Details full screen mode
    @Published var isCourseDetailPresented: Bool = false
    @Published var isSpecializationDetailPresented: Bool = false
    
    /// Modal mode
    @Published var isSingInModalPresented: Bool = false
    
    @Published var navigationTitle: String = ""
    
    /// Scroll detection
    @Published var hasScrolled: Bool = false
    @Published var scrollNamespace = "scroll"
    
    private let titles = [
        "Academy",
        "Stocks",
        "Stocks UIKit",
        "Market News",
        "Styles Guide"
    ]
    
    /// Set of an 'AnyCancellable' to store all subscriptions
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        self.setupSubscriptions()
    }
    
    // MARK: - Private
    private func setupSubscriptions() {
        
        self.$isCourseDetailPresented
            .receive(on: RunLoop.main)
            .sink { [unowned self] value in
                if value {
                    self.isNavigationBarPresented = false
                }
                else {
                    if self.isSpecializationDetailPresented == false {
                        self.isNavigationBarPresented = true
                    }
                }
            }
            .store(in: &subscriptions)
        
        
        self.$isSpecializationDetailPresented
            .receive(on: RunLoop.main)
            .sink { [unowned self] value in
                if value {
                    self.isNavigationBarPresented = false
                }
                else {
                    self.isNavigationBarPresented = true
                }
            }
            .store(in: &subscriptions)
        
        self.$tabSelection
            .receive(on: RunLoop.main)
            .sink { [unowned self] selection in
                
                self.isNavigationBarPresented = true
                self.isCourseDetailPresented = false
                self.isSpecializationDetailPresented = false
                
                if selection == 2 {
                    self.tabPlusTapped = true
                }
                else {
                    self.tabPlusTapped = false
                    self.navigationTitle = titles[self.tabSelection]
                }
            }
            .store(in: &subscriptions)
        
    }
}
