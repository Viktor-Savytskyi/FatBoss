//
//  LoginModuleInitializer.swift
//  FatBoss
//
//  Created by 12345 on 26.06.2023.
//

import UIKit

final class LoginModuleInitializer {
    
    static func createLoginModule() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "LoginView") as! LoginView
        let router = LoginRouter()
        let interactor = LoginInteractor()
        
        let presenter = LoginPresenter(view: view,
                                       router: router,
                                       interactor: interactor)
        presenter.keyChainManager = KeyChainManager()
        presenter.accountManager = AccountManager()
        view.output = presenter
        return view
    }
}
