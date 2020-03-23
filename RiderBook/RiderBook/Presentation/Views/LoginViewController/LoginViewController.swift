//
//  LoginViewController.swift
//  RiderBook
//
//  Created by Pere Almendro on 22/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {// BaseViewController<LoginPresenter> {
    
    // MARK: - Outlets
    
    @IBOutlet weak var usernameTextField: RBTextField!
    @IBOutlet weak var passwordTextField: RBTextField!
    @IBOutlet weak var loginButton: RBButton!
    @IBOutlet weak var guestButton: RBButton!
    
    // MARK: - Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
        setupTextFields()
    }
    
    // MARK: - Private
    
    private func setupButtons() {
        loginButton.setTitle(text: "¡Entra!")
        loginButton.delegate = self
        
        guestButton.setTitle(text: "¡Entra como invitado!")
        guestButton.delegate = self
    }
    
    private func setupTextFields() {
        usernameTextField.setKeyboardType(keyboadrdType: .emailAddress)
        usernameTextField.setplaceholder(placeholder: "Email")
        
        passwordTextField.secureType()
        passwordTextField.setplaceholder(placeholder: "Password")
    }
}

// MARK: - RBButtonDelegate

extension LoginViewController: RBButtonDelegate {
    func rbButtonAction(_ sender: RBButton) {
        if sender == loginButton {
//            presenter.loginButtonAction()
        } else if sender == guestButton {
//            presenter.guestButtonAction()
        }
    }
}