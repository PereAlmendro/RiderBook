//
//  LoginPresenter.swift
//  RiderBook
//
//  Created by Pere Almendro on 22/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

class LoginPresenter: BasePresenter {
    
    private var loginRouter: LoginRouter
    
    // MARK: - Lyfecycle
    
    init(loginRouter: LoginRouter) {
        self.loginRouter = loginRouter
    }
    
    // MARK: - User Actions
    
    func loginButtonAction() {
        // TODO : Login ¿firebase/local?
    }
    
    func guestButtonAction() {
        loginRouter.continueAsGuest()
    }
}
