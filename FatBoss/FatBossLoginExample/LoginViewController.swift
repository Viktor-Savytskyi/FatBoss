//
//  LoginViewController.swift
//  EkreativeSnacks
//
//  Created by Oleksand Atamanskyi on 10/28/19.
//  Copyright © 2019 Oleksand Atamanskyi. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

final class LoginViewController: NoNavigationBarViewController, StoryboardLoadable {
    
    // MARK: - IBoutlets
    
    @IBOutlet weak var firstNameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var lastNameTextField: SkyFloatingLabelTextField!
    
    // MARK: - Dependencies
    
    var loginPresenter: LoginPresenter!
    
    @IBAction private func loginAction(_ sender: Any) {
        guard loginPresenter.validate(firstName: firstNameTextField.text, lastName: lastNameTextField.text) else {
            return
        }
        
        let name = firstNameTextField.text! + " " + lastNameTextField.text!
        loginPresenter.save(user: .init(username: name))
    }
}
