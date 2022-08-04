//
//  Extension+UIViewController.swift
//  StocksAcademy
//
//  Created by bovsheva on 22.06.2022.
//

import Foundation
import UIKit


extension UIViewController {
    
    func makeLoadingPlaceholder() -> LoadingPlaceholderView {
        let placeholder = LoadingPlaceholderView()
        view.addSubview(placeholder)
        return placeholder
    }
    
    func makeErrorPlaceholder(with systemImageName: String? = nil) -> ErrorPlaceholderView {
        let placeholder = ErrorPlaceholderView()
        if let imageName = systemImageName {
            placeholder.setImage(with: imageName)
        }
        view.addSubview(placeholder)
        return placeholder
    }
    
    func layoutPlaceholder(placeholder: UIView) {
        placeholder.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            placeholder.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            placeholder.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 20),
            //placeholder.widthAnchor.constraint(equalToConstant: 300),
            //placeholder.heightAnchor.constraint(equalToConstant: 300),
            placeholder.widthAnchor.constraint(equalToConstant: view.width),
            placeholder.heightAnchor.constraint(equalToConstant: view.height),

        ])
    }
}
