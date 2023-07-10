//
//  AddProductModuleInitializer.swift
//  FatBoss
//
//  Created by 12345 on 30.06.2023.
//

import UIKit

final class AddProductModuleInitializer {
    
    static func createAddProductModule() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "AddProductView") as! AddProductView
        let router = AddProductRouter()
        let interactor = AddProductInteractor()
        interactor.snacksManager = SnacksManager()
        let presenter = AddProductPresenter(view: view, router: router, interactor: interactor)
        view.addProductViewOutput = presenter
        return view
    }
}
