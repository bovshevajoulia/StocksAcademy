//
//  LoginCoordinator.swift
//  StocksAcademy
//
//  Created by bovsheva on 27.07.2022.
//

import Foundation
import SwiftUI
import Combine


final class LoginCoordinator: Coordinator {
    
    // MARK: - Private
    
    private let hasLogin: CurrentValueSubject<Bool,Never>
    
    // MARK: _ init
    init(hasLogin: CurrentValueSubject<Bool,Never>) {
        self.hasLogin = hasLogin
    }
    
    // MARK: - Public
    public var rootViewController: UIViewController?
    
    func start() {
        
        let view = LoginView {  [weak self] in
            self?.hasLogin.send(true)
        } onSingUp: { [weak self] in
            self?.hasLogin.send(true)
        }
        
        self.rootViewController = UIHostingController(rootView: view)
    }
    
    func dismiss() {
        // TODO: free resources
    }
}
