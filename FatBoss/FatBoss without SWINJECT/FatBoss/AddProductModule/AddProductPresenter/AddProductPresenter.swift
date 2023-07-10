//
//  AddProductPresenter.swift
//  FatBoss
//
//  Created by 12345 on 30.06.2023.
//

import Foundation

protocol AddProductPresenterInput {
    func addNewProduct(newSnack: SnackModel)
}

final class AddProductPresenter {
    
    var view: AddProductViewInput
    var router: AddProductRouterInput
    var interactor: AddProductInteractorInput
    
    init(view: AddProductViewInput, router: AddProductRouterInput, interactor: AddProductInteractorInput) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func createSnackModel(name: String, dateString: String, price: String) -> SnackModel {
        let correctedDate = String(dateString.dropLast(2))
        let dateFormatter = DateFormatter.setDateFormat(dateFormat: .dMMMyyyy)
        let date = dateFormatter.date(from: correctedDate) ?? Date()
        let newSnack = SnackModel()
        newSnack.price = Int(price) ?? 0
        newSnack.productName = name
        newSnack.date = date
        return newSnack
    }
    
    func validateNewProductFields(name: String?, date: String?, price: String?) throws -> SnackModel {
        guard let name, !name.isEmpty   else { throw ValidationError.productNameError }
        guard let date, !date.isEmpty   else { throw ValidationError.productDateError }
        guard let price, !price.isEmpty else { throw ValidationError.productPriceError }
        return createSnackModel(name: name, dateString: date, price: price)
    }
}

extension AddProductPresenter: AddProductViewOutput {
    func closeAddProductScreen() {
        router.closeScreen()
    }
    
    func addProduct(name: String?, date: String?, price: String?) -> Bool {
        do {
            let newSnack = try validateNewProductFields(name: name, date: date, price: price)
            interactor.addNewProduct(newSnack: newSnack)
            return true
        } catch {
            print((error as! ValidationError).description)
            return false
        }
    }
}
