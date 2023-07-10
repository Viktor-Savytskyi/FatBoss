//
//  KeyChainManager.swift
//  FatBoss
//
//  Created by 12345 on 26.06.2023.
//

import Foundation
import Locksmith

protocol KeyChainManagerProtocol {
    func create(userAccount: UserEntity?)
    func get(userAccount: UserEntity) -> UserEntity?
}

final class KeyChainManager: KeyChainManagerProtocol {
    
    private let firstNameKey = "firstName"
    private let lastNameKey = "lastName"
    
    func create(userAccount: UserEntity?)  {
        guard let userAccount else { return }
        do {
            try Locksmith.saveData(data: [firstNameKey : userAccount.firstName,
                                           lastNameKey : userAccount.lastName],
                                   forUserAccount: userAccount.firstName)
        } catch {
            print("cant save data \(error)")
        }
    }
    
    func get(userAccount: UserEntity) -> UserEntity? {
        if let account = Locksmith.loadDataForUserAccount(userAccount: userAccount.firstName) {
            return UserEntity(firstName: account[firstNameKey] as! String,
                              lastName:  account[lastNameKey] as! String)
        } else {
            print("error to get account")
            return nil
        }
    }
}
