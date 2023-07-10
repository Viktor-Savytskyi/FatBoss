//
//  Extension+SkyFloatingLabelTextField.swift
//  FatBoss
//
//  Created by 12345 on 26.06.2023.
//

import Foundation
import SkyFloatingLabelTextField

extension SkyFloatingLabelTextField {
    func setInputViewDatePicker(target: Any, selector: Selector) {
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 300))
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        inputView = datePicker
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 45))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel))
        let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector)
        toolBar.setItems([cancel, flexible, barButton], animated: false)
        inputAccessoryView = toolBar
    }
    
    @objc func tapCancel() {
        resignFirstResponder()
    }
}
