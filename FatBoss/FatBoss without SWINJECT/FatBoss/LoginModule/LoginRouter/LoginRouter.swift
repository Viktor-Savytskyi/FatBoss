//
//  LoginRouter.swift
//  FatBoss
//
//  Created by 12345 on 26.06.2023.
//

import Foundation

protocol LoginRouterInput: AnyObject {
    func openSnackScreen(userAccount: UserEntity)
}

final class LoginRouter: LoginRouterInput {
    func openSnackScreen(userAccount: UserEntity) {
        GlobalRouter.shared.moveTo(screen: .snacks(userAccount))
    }
}
