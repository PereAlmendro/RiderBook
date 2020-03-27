//
//  LoginPresenter.swift
//  RiderBook
//
//  Created by Pere Almendro on 22/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

class LoginPresenter: BasePresenter {
    
    // MARK: - Properties
    
    private let loginRouter: LoginRouter
    private let loginInteractor: LoginInteractor
    
    // MARK: - Lyfecycle
    
    init(loginRouter: LoginRouter, loginInteractor: LoginInteractor) {
        self.loginRouter = loginRouter
        self.loginInteractor = loginInteractor
    }
    
    // MARK: - User Actions
    
    func loginButtonAction() {
        // TODO : Login ¿firebase/local?
    }
    
    func guestButtonAction() {
        loginRouter.showHomeAsGuest()
    }
}
