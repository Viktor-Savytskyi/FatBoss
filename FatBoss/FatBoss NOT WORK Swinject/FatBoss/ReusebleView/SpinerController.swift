//
//  SpinerController.swift
//  FatBoss
//
//  Created by 12345 on 28.06.2023.
//

import UIKit

final class SpinerController: UIViewController {
    
    private let loaderView = UIActivityIndicatorView(style: .large)
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.2)        
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        loaderView.startAnimating()
        view.addSubview(loaderView)
        
        loaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loaderView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
