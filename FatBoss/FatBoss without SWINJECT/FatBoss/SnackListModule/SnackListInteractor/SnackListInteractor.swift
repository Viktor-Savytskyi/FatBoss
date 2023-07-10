//
//  SnackListInteractor.swift
//  FatBoss
//
//  Created by 12345 on 27.06.2023.
//

import Foundation

protocol SnackListInteractorInput {
    var snackListInteractorOutput: SnackListInteractorOutput? { get set }
    func fetchSnackList()
    func deleteSnack(id: Int)
    func getKeyChainUserAccount(userAccount: UserEntity)
}

protocol SnackListInteractorOutput {
    func returnSnackList(snacks: [SnackModel]?)
    func returnUserAccount(userAccount: UserEntity)
}

final class SnackListInteractor: SnackListInteractorInput {
    var snackManager: SnacksManagerProtocol!
    var keyChainManager: KeyChainManagerProtocol!
    var snackListInteractorOutput: SnackListInteractorOutput?
    var loaderDelegate: LoadingIndicatorProtocol?
    
    func fetchSnackList() {
        loaderDelegate?.show()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.snackManager.fetchSnackList { snacks in
                self?.loaderDelegate?.hide()
                self?.snackListInteractorOutput?.returnSnackList(snacks: Array(snacks))
            }
        }
    }
    
    func deleteSnack(id: Int) {
        do {
            try snackManager?.removeSnack(id: id)
        } catch {
            print(error)
        }
    }
    
    func getKeyChainUserAccount(userAccount: UserEntity) {
        if let userKeyChainAccount = keyChainManager.get(userAccount: userAccount) {
            snackListInteractorOutput?.returnUserAccount(userAccount: userKeyChainAccount)
        } else {
            print("cant get user KeyChain account")
        }
    }
}

extension SnackListInteractor: DidUpdateSnacksProtocol {
    func snacksDidUpdate() {
        fetchSnackList()
    }
}
