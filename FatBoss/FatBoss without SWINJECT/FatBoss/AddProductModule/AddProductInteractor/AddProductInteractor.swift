//
//  AddProductInteractor.swift
//  FatBoss
//
//  Created by 12345 on 30.06.2023.
//

import Foundation

protocol AddProductInteractorInput {
    func addNewProduct(newSnack: SnackModel)
}

final class AddProductInteractor: AddProductInteractorInput {
    
    var snacksManager: SnacksManagerProtocol?
    
    func addNewProduct(newSnack: SnackModel) {
        do {
            try snacksManager?.save(snack: newSnack)
        } catch {
            print(error)
        }
    }
    
    func addProduct(newSnack: SnackModel) {
        addNewProduct(newSnack: newSnack)
    }
}
