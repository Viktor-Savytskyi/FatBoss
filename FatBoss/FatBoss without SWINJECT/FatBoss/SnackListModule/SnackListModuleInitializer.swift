//
//  SnackListModuleInitializer.swift
//  FatBoss
//
//  Created by 12345 on 28.06.2023.
//

import UIKit

class SnackListModuleInitializer {
    
    static func createSnackListModule(userAccount: UserEntity) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "SnackListView") as! SnackListView
        let router = SnackListRouter()
        let interactor = SnackListInteractor()
        interactor.snackManager = SnacksManager()
        interactor.keyChainManager = KeyChainManager()
        let presenter = SnackListPresenter(view: view,
                                           interactor: interactor,
                                           router: router,
                                           userAccount: userAccount)
        view.snackListViewOutput = presenter
        interactor.snackManager.snackManagerDelegate = interactor
        interactor.snackListInteractorOutput = presenter
        interactor.loaderDelegate = view
        return view
    }
}
