//
//  ViewController.swift
//  FatBoss
//
//  Created by 12345 on 26.06.2023.
//

import UIKit
import SkyFloatingLabelTextField

protocol LoginViewInput {
    var output: LoginViewOutput? { get set }
}

protocol LoginViewOutput {
    func loginUserAccountWith(firstName: String, lastName: String)
}

final class LoginView: BaseView, LoginViewInput {
    
    @IBOutlet private weak var fatBossTitleImageView: UIImageView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var firstNameSkyTextField: SkyFloatingLabelTextField!
    @IBOutlet private weak var lastNameSkyTextField: SkyFloatingLabelTextField!
    @IBOutlet private weak var loginButton: UIButton!
    
    var output: LoginViewOutput?
    
    override func prepareUI() {
        super.prepareUI()
        loginButton.layer.cornerRadius = loginButton.frame.height / 2
        firstNameSkyTextField.delegate = self
        lastNameSkyTextField.delegate = self
        firstNameSkyTextField.returnKeyType = .next
        lastNameSkyTextField.returnKeyType = .done
    }
    
    @IBAction private func loginAction(_ sender: Any) {
        output?.loginUserAccountWith(firstName: firstNameSkyTextField.text!,
                                         lastName: lastNameSkyTextField.text!)
    }
}

extension LoginView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == firstNameSkyTextField {
            lastNameSkyTextField.becomeFirstResponder()
        } else {
            view.endEditing(true)
        }
        return true
    }
}
