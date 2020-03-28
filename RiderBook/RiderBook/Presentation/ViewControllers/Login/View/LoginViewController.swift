//
//  LoginViewController.swift
//  RiderBook
//
//  Created by Pere Almendro on 22/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController<LoginPresenter> {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var usernameTextField: RBTextField!
    @IBOutlet private weak var passwordTextField: RBTextField!
    @IBOutlet private weak var loginButton: RBButton!
    @IBOutlet private weak var guestButton: RBButton!
    
    // MARK: - Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
        setupTextFields()
    }
    
    // MARK: - Private
    
    private func setupButtons() {
        loginButton.setTitle(text: "log_in".localized())
        loginButton.delegate = self
        
        guestButton.setTitle(text: "Join_as_guest!".localized())
        guestButton.delegate = self
    }
    
    private func setupTextFields() {
        usernameTextField.setKeyboardType(keyboadrdType: .emailAddress)
        usernameTextField.setplaceholder(placeholder: "Email".localized())
        
        passwordTextField.secureType()
        passwordTextField.setplaceholder(placeholder: "Password".localized())
    }
}

// MARK: - RBButtonDelegate

extension LoginViewController: RBButtonDelegate {
    func rbButtonAction(_ sender: RBButton) {
        if sender == loginButton {
            presenter.login(username: usernameTextField.getText(),
                            password: passwordTextField.getText())
        } else if sender == guestButton {
            presenter.guestButtonAction()
        }
    }
}
