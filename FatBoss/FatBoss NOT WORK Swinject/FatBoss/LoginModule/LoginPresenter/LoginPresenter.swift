//
//  LoginPresenter.swift
//  FatBoss
//
//  Created by 12345 on 26.06.2023.
//

import UIKit

protocol LoginPresenterInput {
    var output: LoginPresenterOutput? { get set }
}

protocol LoginPresenterOutput {
    func didLoginAccount(account: UserEntity)
}

final class LoginPresenter {
    
    var view: LoginViewInput?
    var router: LoginRouterInput?
    var interactor: LoginInteractorInput?
    var keyChainManager: KeyChainManagerProtocol?
    var accountManager: AccountManagerProtocol?
    
    init(view: LoginViewInput?,
         router: LoginRouterInput?,
         interactor: LoginInteractorInput?,
         keyChainManager: KeyChainManagerProtocol?,
         accountManager: AccountManagerProtocol?) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.keyChainManager = keyChainManager
        self.accountManager = accountManager
    }
    
    func loginUserAccount(firstName: String, lastName: String) {
        do {
            try accountManager?.validateUser(firstName: firstName, lastName: lastName)
            didLoginAccount(account: UserEntity(firstName: firstName, lastName: lastName))
        } catch {
            print((error as! ValidationError).description)
        }
    }
    
    //    need to create account in KeyChain
    //    func createUserAccount(firstName: String, lastName: String) {
    //        keyChainManager.create(userAccount: UserEntity(firstName: firstName, lastName: lastName))
    //    }
    
}

extension LoginPresenter: LoginViewOutput {
    func loginUserAccountWith(firstName: String, lastName: String) {
        loginUserAccount(firstName: firstName, lastName: lastName)
    }
}

extension LoginPresenter: LoginInteractorOutput {
    func didLoginAccount(account: UserEntity) {
        router?.openSnackScreen(userAccount: account)
    }
}
