//
//  AppCoordinator.swift
//  StocksAcademy
//
//  Created by bovsheva on 15.07.2022.
//

import Foundation
import UIKit
import Combine


final class AppCoordinator: Coordinator {
    
    // MARK: - Private
    private let window: UIWindow
    
    private let hasSeenOnboarding = CurrentValueSubject<Bool,Never>(false)
    private let hasLogin = CurrentValueSubject<Bool,Never>(false)
    
    private let goToHomeFromStock = CurrentValueSubject<Bool,Never>(false)
    private let goToStock = CurrentValueSubject<Bool,Never>(false)
    
    private var subscriptions = Set<AnyCancellable>()
    
    private enum FlowName: String {
        case onboarding
        case login
        case main
        case stock
    }
    
    private struct Constants {
        static let onboardingKey = "onboardingKey"
        static let loginKey = "loginKey"
    }
    
    // child coordinators
    private var childCoordinators: [String:Coordinator] = [:]
    
    
    // MARK: - init
    init(with window: UIWindow) {
        self.window = window
        
        self.setupSubscriptions()
        self.setupOnboardingValue()
        self.setupLoginValue()
    }
    
    deinit {
        dismiss()
    }
    
    // MARK: - Public
    
    // MARK: - Coordinator
    func start() {
        
        window.makeKeyAndVisible()
    }
    
    private func setupSubscriptions() {
        
        self.hasSeenOnboarding
            .removeDuplicates()
            .sink { [weak self] hasSeen in
                
                if hasSeen {
                    self?.startLoginFlow()
                    self?.stopFlow(FlowName.onboarding.rawValue)
                }
                else {
                    self?.startOnbordingFlow()
                }
            }
            .store(in: &self.subscriptions)
        
        self.hasLogin
            .removeDuplicates()
            .sink { [weak self] hasLogin in
                if hasLogin {
                    self?.startMainFlow()
                    self?.stopFlow(FlowName.login.rawValue)
                }
                else {
                    if self?.hasSeenOnboarding.value == true {
                        self?.startLoginFlow()
                    }
                }
            }
            .store(in: &self.subscriptions)
        
        self.goToHomeFromStock
            .sink { [weak self] value in
                if value {
                    self?.startMainFlow()
                    self?.stopFlow(FlowName.stock.rawValue)
                    self?.goToStock.send(false)
                }
                
            }
            .store(in: &self.subscriptions)
        
        self.goToStock
            .removeDuplicates()
            .sink { [weak self] value in
                if value {
                    self?.startStocksFlow()
                }
            }
            .store(in: &self.subscriptions)
    }
    
    func dismiss() {
        // MARK: free resources
        _ = childCoordinators.map { $0.value.dismiss() }
        childCoordinators.removeAll()
        _ = subscriptions.map{ $0.cancel() }
    }
    
    // MARK: - Private
    private func setupOnboardingValue() {
        
        let value = UserDefaults.standard.bool(forKey: Constants.onboardingKey)
        self.hasSeenOnboarding.send(value)
        
        self.hasSeenOnboarding
            .removeDuplicates()
            .sink { value in
                UserDefaults.standard.set(value, forKey: Constants.onboardingKey)
            }
            .store(in: &self.subscriptions)
    }
    
    private func setupLoginValue() {
        
        let value = UserDefaults.standard.bool(forKey: Constants.loginKey)
        self.hasLogin.send(value)
        
        self.hasLogin
            .removeDuplicates()
            .sink { value in
                UserDefaults.standard.set(value, forKey: Constants.loginKey)
            }
            .store(in: &self.subscriptions)
    }
    
    /// Start Onbording flow (SwiftUI)
    private func startOnbordingFlow() {
        
        let coordinator = OnboardingCoordinator(hasSeenOnboarding: self.hasSeenOnboarding)
        coordinator.start()
        childCoordinators[FlowName.onboarding.rawValue] = coordinator
        
        window.rootViewController = coordinator.rootViewController
    }
    
    /// Start Login flow (SwiftUI)
    private func startLoginFlow() {
        
        let coordinator = LoginCoordinator(hasLogin: self.hasLogin)
        coordinator.start()
        childCoordinators[FlowName.login.rawValue] = coordinator
        
        window.rootViewController = coordinator.rootViewController
    }
    
    /// Start Main flow (SwiftUI)
    private func startMainFlow() {
        let coordinator = MainCoordinator(goToStock: self.goToStock)
        coordinator.start()
        childCoordinators[FlowName.main.rawValue] = coordinator
        
        window.rootViewController = coordinator.rootViewController
    }
    
    
    /// Start Stock flow (UIKit)
    private func startStocksFlow() {
        let coordinator = StocksCoordinator(goToHome: self.goToHomeFromStock)
        coordinator.start()
        childCoordinators[FlowName.stock.rawValue] = coordinator
        
        window.rootViewController = coordinator.rootViewController
    }
    
    /// Stops flow and free all flow resourses
    /// - Parameter name: flow name
    private func stopFlow(_ name: String) {
        childCoordinators[name]?.dismiss()
        childCoordinators.removeValue(forKey: name)
    }
}
