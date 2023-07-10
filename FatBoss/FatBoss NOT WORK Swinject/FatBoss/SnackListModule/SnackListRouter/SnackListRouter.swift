//
//  SnackListRouter.swift
//  FatBoss
//
//  Created by 12345 on 27.06.2023.
//

import Foundation

protocol SnackListRouterInput {
    func showPopupScreen()
    func moveBack()
}

final class SnackListRouter: SnackListRouterInput {
    
    func showPopupScreen() {
        GlobalRouter.shared.moveTo(screen: .addProduct)
    }
    
    func moveBack() {
        GlobalRouter.shared.moveTo(screen: .popToParent)
    }
}
