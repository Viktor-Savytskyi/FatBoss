//
//  GlobalRouter.swift
//  FatBoss
//
//  Created by 12345 on 26.06.2023.
//

import UIKit
import Swinject
import SwinjectStoryboard

enum AppScreensNavigation {
    case snacks(UserEntity)
    case addProduct
    case popToParent
    case dismissModalScreen
}

final class GlobalRouter {
    
    private var navigationController: UINavigationController?
    var container = Container()
    var swinjectStoryboard: SwinjectStoryboard?
    static let shared = GlobalRouter()
    private let mainStoryboardName = "Main"
    
    
    init() {
        setupStoryboardWithNavcontroller()
    }
    
    func setNavigationController() -> UINavigationController {
       return navigationController ?? UINavigationController()
    }
    
    private func setupStoryboardWithNavcontroller() {
        LoginModuleInitializer.createLoginModule(container: container)
        swinjectStoryboard = SwinjectStoryboard.create(name: mainStoryboardName, bundle: nil, container: container)
        navigationController = swinjectStoryboard?.instantiateInitialViewController()
    }
    
    
    
    //        init(navigationController: UINavigationController) {
    //            self.navigationController = navigationController
    //        }
    //
    //        func getRootController(in storyboard: SwinjectStoryboard) -> UIViewController {
    //            let rootViewController = LoginModuleInitializer.createLoginModule()
    //
    //            if var loginView = rootViewController as? LoginViewInput {
    //                let container = SwinjectStoryboard.defaultContainer
    //                if let output = container.resolve(LoginViewOutput.self) {
    //                    loginView.output = output
    //                }
    //            }
    //
    //            navigationController.setViewControllers([rootViewController], animated: true)
    //            return navigationController
    //        }
    
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
        SnackListModuleInitializer.createSnackListModule(container: container)
        guard let swinjectStoryboard else { return }
        let snackScreen = swinjectStoryboard.instantiateViewController(withIdentifier: "SnackListView")
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
