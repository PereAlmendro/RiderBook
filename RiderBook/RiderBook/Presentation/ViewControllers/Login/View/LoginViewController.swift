//
//  LoginViewController.swift
//  RiderBook
//
//  Created by Pere Almendro on 22/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import UIKit
import GoogleSignIn

class LoginViewController: BaseViewController<LoginPresenter> {
    
    // MARK: - Outlets
    @IBOutlet private weak var loginButton: RBButton!
    @IBOutlet private weak var guestButton: RBButton!
    
    // MARK: - Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
    }
    
    // MARK: - Private functions
    
    private func setupButtons() {
        loginButton.setTitle(text: "log_in_with_google".localized())
        loginButton.delegate = self
        
        guestButton.setTitle(text: "Join_as_guest!".localized())
        guestButton.delegate = self
    }
}

// MARK: - RBButtonDelegate

extension LoginViewController: RBButtonDelegate {
    func rbButtonAction(_ sender: RBButton) {
        if sender == loginButton {
            presenter.loginWithGoogle()
        } else if sender == guestButton {
            presenter.guestButtonAction()
        }
    }
}
