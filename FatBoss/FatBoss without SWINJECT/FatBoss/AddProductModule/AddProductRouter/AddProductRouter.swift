//
//  AddProductRouter.swift
//  FatBoss
//
//  Created by 12345 on 30.06.2023.
//

import UIKit

protocol AddProductRouterInput {
    func closeScreen()
}

final class AddProductRouter: AddProductRouterInput {
    
    func closeScreen() {
        GlobalRouter.shared.moveTo(screen: .dismissModalScreen)
    }
}
