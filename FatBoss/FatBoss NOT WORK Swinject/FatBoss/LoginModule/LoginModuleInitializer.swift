//
//  LoginModuleInitializer.swift
//  FatBoss
//
//  Created by 12345 on 26.06.2023.
//

import UIKit
import Swinject
import SwinjectStoryboard

final class LoginModuleInitializer {
    
    static func createLoginModule(container: Container) {
        createDependensies(container: container)
        injectDependinsies(container: container)
    }
    
    private static func createDependensies(container: Container) {
        container.register(KeyChainManagerProtocol.self) { _ in KeyChainManager() }
        container.register(AccountManagerProtocol.self) { _ in AccountManager() }
        
        container.register(LoginRouterInput.self) { _ in LoginRouter() }
        container.register(LoginInteractorInput.self) { _ in LoginInteractor() }
        container.register(LoginViewInput.self) { _ in LoginView() }
        container.register(LoginViewOutput.self) { r in
            let presenter = LoginPresenter(view: r.resolve(LoginViewInput.self),
                                           router: r.resolve(LoginRouterInput.self),
                                           interactor: r.resolve(LoginInteractorInput.self),
                                           keyChainManager: r.resolve(KeyChainManagerProtocol.self),
                                           accountManager: r.resolve(AccountManagerProtocol.self))
            return presenter
        }
    }
    
    private static func injectDependinsies(container: Container) {
        container.storyboardInitCompleted(LoginView.self) { r, viewController in
            viewController.output = r.resolve(LoginViewOutput.self)
        }
    }
}
