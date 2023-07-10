//
//  GlobalRouter.swift
//  FatBoss
//
//  Created by 12345 on 26.06.2023.
//

import UIKit

enum AppScreensNavigation {
    case snacks(UserEntity)
    case addProduct
    case popToParent
    case dismissModalScreen
}

final class GlobalRouter {
    
    private var navigationController: UINavigationController!
    static let shared = GlobalRouter(navigationController: UINavigationController())
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func setRootNavigationController() -> UINavigationController {
        navigationController.addChild(LoginModuleInitializer.createLoginModule())
        return navigationController
    }
    
    func moveTo(screen: AppScreensNavigation) {
        switch screen {
        case .snacks(let userEntity):
            openSnacksListkScreen(userAccount: userEntity)
        case .addProduct:
            openAddProductScreen()
        case .popToParent:
            moveToParent()
        case .dismissModalScreen:
            hideModalScreen()
        }
    }
    
    private func openSnacksListkScreen(userAccount: UserEntity) {
        let snackScreen = SnackListModuleInitializer.createSnackListModule(userAccount: userAccount)
        navigationController?.pushViewController(snackScreen, animated: true)
    }
    
    private func openAddProductScreen() {
        let addProductScreen = AddProductModuleInitializer.createAddProductModule()
        addProductScreen.modalPresentationStyle = .overCurrentContext
        navigationController?.present(addProductScreen, animated: true)
    }
    
    private func hideModalScreen() {
        navigationController?.dismiss(animated: true)
    }
    
    private func moveToParent() {
        navigationController?.popViewController(animated: true)
    }
}
