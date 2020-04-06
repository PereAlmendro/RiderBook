//
//  RBTextField.swift
//  RiderBook
//
//  Created by Pere Almendro on 22/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import UIKit

class RBTextField: NibView {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var textField: UITextField!
    
    // MARK: - Public functions
    
    func getText() -> String? {
        return textField.text
    }
    
    func setplaceholder(placeholder: String) {
        textField.placeholder = placeholder
    }
    
    func setKeyboardType(keyboadrdType: UIKeyboardType) {
        textField.keyboardType = keyboadrdType
    }
    
    func secureType() {
        textField.isSecureTextEntry = true
    }
    
}
