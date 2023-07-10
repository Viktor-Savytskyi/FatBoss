//
//  LoginPresenter.swift
//  EkreativeSnacks
//
//  Created by Oleksand Atamanskyi on 10/28/19.
//  Copyright © 2019 Oleksand Atamanskyi. All rights reserved.
//

import Foundation

protocol LoginPresenterOutput {
    func showSnacks()
}

final class LoginPresenter {
    private let loginInteractor: LoginInteractor
    private let loginRouter: LoginRouter
    
    init(loginInteractor: LoginInteractor, loginRouter: LoginRouter) {
        self.loginInteractor = loginInteractor
        self.loginRouter = loginRouter
    }
    
    func save(user: User) {
        loginInteractor.save(user: user)
    }
}

// MARK: - LoginPresenterOutput

extension LoginPresenter: LoginPresenterOutput {
    func showSnacks() {
        loginRouter.showSnacks()
    }
}

// MARK: - Validatable

extension LoginPresenter: Validatable {
    func validate(firstName: String?, lastName: String?) -> Bool {
        do {
            try validate(rule: .firstName, value: firstName ?? "")
            try validate(rule: .lastName, value: lastName ?? "")
            
            return true
        } catch {
            if let validationError = error as? ValidationRulePattern {
                // need to add popup
            }
            
            return false
        }
    }
}
