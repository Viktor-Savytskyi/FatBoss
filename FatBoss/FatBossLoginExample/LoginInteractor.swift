//
//  LoginInteractor.swift
//  EkreativeSnacks
//
//  Created by Oleksand Atamanskyi on 10/28/19.
//  Copyright © 2019 Oleksand Atamanskyi. All rights reserved.
//

import Foundation

final class LoginInteractor {
    var loginPresenterOutput: LoginPresenterOutput?
    var keychainService: KeychainService?
    
    func save(user: User) {
        keychainService?.set(value: user.username, key: KeychainKeys.userData)
        loginPresenterOutput?.showSnacks()
    }
}
