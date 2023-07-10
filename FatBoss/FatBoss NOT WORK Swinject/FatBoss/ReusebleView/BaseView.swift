//
//  BaseView.swift
//  FatBoss
//
//  Created by 12345 on 26.06.2023.
//

import UIKit

class BaseView: UIViewController {
    
    private let spinerController = SpinerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func prepareUI() {
        view.backgroundColor = Constants.Colors.background
    }
    
    func startLoading() {
        self.addChild(spinerController)
        spinerController.view.frame = self.view.frame
        self.view.addSubview(spinerController.view)
        spinerController.didMove(toParent: self)
    }
    
    func stopLoading() {
        spinerController.willMove(toParent: nil)
        spinerController.removeFromParent()
        spinerController.view.removeFromSuperview()
    }
}

