//
//  AddProductView.swift
//  FatBoss
//
//  Created by 12345 on 29.06.2023.
//

import UIKit
import SkyFloatingLabelTextField

protocol AddProductViewInput {
    var addProductViewOutput: AddProductViewOutput? { get set }
}

protocol AddProductViewOutput {
    func closeAddProductScreen()
    func addProduct(name: String?, date: String?, price: String?) -> Bool
}

final class AddProductView: BaseView, AddProductViewInput {
    
    @IBOutlet private weak var dateSkyTextField: SkyFloatingLabelTextField!
    @IBOutlet private weak var productNameSkyTextField: SkyFloatingLabelTextField!
    @IBOutlet private weak var priceSkyTextField: SkyFloatingLabelTextField!
    
    var addProductViewOutput: AddProductViewOutput?
    
    override func prepareUI() {
        super.prepareUI()
        view.backgroundColor = .black.withAlphaComponent(0.4)
        setupDateTextField()
        priceSkyTextField.keyboardType = .numberPad
    }
    
    private func setupDateTextField() {
        self.dateSkyTextField.setInputViewDatePicker(target: self, selector: #selector(datePickerDoneAction))
    }
    
    @objc private func datePickerDoneAction() {
        if let datePicker = self.dateSkyTextField.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter.setDateFormat(dateFormat: .dMMMyyyy)
            self.dateSkyTextField.text = "\(dateFormatter.string(from: datePicker.date)) р."
        }
        self.dateSkyTextField.resignFirstResponder()
    }
    
    @IBAction private func closeScreenAction(_ sender: Any) {
        addProductViewOutput?.closeAddProductScreen()
    }
    
    @IBAction private func addProductAction(_ sender: Any) {
        if let addProductViewOutput, addProductViewOutput.addProduct(name: productNameSkyTextField.text,
                                                                     date: dateSkyTextField.text,
                                                                     price: priceSkyTextField.text) {
            addProductViewOutput.closeAddProductScreen()
        }
    }
}
