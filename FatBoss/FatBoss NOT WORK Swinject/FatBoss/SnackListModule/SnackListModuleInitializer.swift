//
//  SnackListModuleInitializer.swift
//  FatBoss
//
//  Created by 12345 on 28.06.2023.
//

import UIKit
import Swinject
import SwinjectStoryboard

class SnackListModuleInitializer {
    
    static func createSnackListModule(container: Container) {
        createDependensies(container: container)
        injectDependinsies(container: container)
    }
    
    static func createDependensies(container: Container) {
        
        
        container.register(LoadingIndicatorProtocol.self) { _ in SnackListView() }
        container.register(SnackListViewInput.self) { _ in SnackListView() }
        container.register(SnackListRouterInput.self) { _ in SnackListRouter() }
        
        //сетим SnackListInteractor реалізацію протоколу DidUpdateSnacksProtocol але ця реєстрація перезаписує ту що нижче, яка відповідає протоколу SnackListInteractorInput
            //якщо продублювати поля при цій реєстрації то буде безкінечний цикл ссилок
        container.register(DidUpdateSnacksProtocol.self) { r in
            SnackListInteractor()
        
        }
        container.register(SnackListInteractorInput.self) { r in
            let interactor = SnackListInteractor()
            interactor.keyChainManager = r.resolve(KeyChainManagerProtocol.self)
            interactor.snackManager = r.resolve(SnacksManagerProtocol.self)
            interactor.loaderDelegate = r.resolve(LoadingIndicatorProtocol.self)
            interactor.snackListInteractorOutput = r.resolve(SnackListInteractorOutput.self)
            return interactor
        }.implements(DidUpdateSnacksProtocol.self)
        
        container.register(SnacksManagerProtocol.self) { r in
            let snackManager = SnacksManager()
            snackManager.snackManagerDelegate = r.resolve(DidUpdateSnacksProtocol.self)
            return snackManager
        }
        container.register(SnackListInteractorOutput.self) { _ in
            SnackListPresenter()
        }
        container.register(SnackListViewOutput.self) { r in
            let presenter = SnackListPresenter()
            presenter.view = r.resolve(SnackListViewInput.self)
            presenter.interactor = r.resolve(SnackListInteractorInput.self)
            presenter.router = r.resolve(SnackListRouterInput.self)
            return presenter
        }
    }
    
    
    static func injectDependinsies(container: Container) {
        container.storyboardInitCompleted(SnackListView.self) { r, viewController in
            viewController.snackListViewOutput = r.resolve(SnackListViewOutput.self)
        }
    }
    
    
    
    
    
    
    
    //    static func createSnackListModule(userAccount: UserEntity) -> UIViewController {
    //        let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //        let view = storyboard.instantiateViewController(withIdentifier: "SnackListView") as! SnackListView
    //        let router = SnackListRouter()
    //        let interactor = SnackListInteractor()
    //        interactor.snackManager = SnacksManager()
    //        interactor.keyChainManager = KeyChainManager()
    //        let presenter = SnackListPresenter(view: view,
    //                                           interactor: interactor,
    //                                           router: router,
    //                                           userAccount: userAccount)
    //        view.snackListViewOutput = presenter
    //        interactor.snackManager.snackManagerDelegate = interactor
    //        interactor.snackListInteractorOutput = presenter
    //        interactor.loaderDelegate = view
    //        return view
    //    }
}
