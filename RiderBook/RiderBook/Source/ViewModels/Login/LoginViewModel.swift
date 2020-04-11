//
//  LoginViewModel.swift
//  RiderBook
//
//  Created by Pere Almendro on 06/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import FirebaseAuth
import Combine

class LoginViewModel: ObservableObject  {
    
    // MARK: - View properties
    
    var screenTitle = "Rider_book"
    
    // MARK: - Private properties
    
    private var loginService: LoginService
    
    init(loginService: LoginService) {
        self.loginService = loginService
    }
    
    //MARK: - User actions
    
    func loginWithGoogle() {
        loginService.loginWithGoogle()
    }
    
    func loginWithFacebook() {
        // TODO
    }
    
}
