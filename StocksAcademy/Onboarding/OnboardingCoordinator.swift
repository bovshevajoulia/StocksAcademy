//
//  OnboardingCoordinator.swift
//  StocksAcademy
//
//  Created by bovsheva on 16.06.2022.
//

import Foundation
import SwiftUI
import Combine


final class OnboardingCoordinator: Coordinator {
    
    // MARK: - Private
    
    private let hasSeenOnboarding: CurrentValueSubject<Bool,Never>
    
    // MARK: _ init
    init(hasSeenOnboarding: CurrentValueSubject<Bool,Never>) {
        self.hasSeenOnboarding = hasSeenOnboarding
    }
    
    // MARK: - Public
    public var rootViewController: UIViewController?
    
    func start() {
        
        let view = OnboardingView() { [weak self] in
            self?.hasSeenOnboarding.send(true)
        }
        
        rootViewController = UIHostingController(rootView: view)
    }
    
    func dismiss() {
        // TODO: free resources
    }
}
