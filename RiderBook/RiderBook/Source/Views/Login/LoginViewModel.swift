//
//  LoginViewModel.swift
//  RiderBook
//
//  Created by Pere Almendro on 06/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject  {
    
    // MARK: - View properties
    
    var screenTitle = "Rider book"
    
    // MARK: - Private properties
    
    private var loginProvider: LoginProvider
    
    init(loginProvider: LoginProvider) {
        self.loginProvider = loginProvider
    }
    
    //MARK: - User actions
    
    func loginWithGoogleAction() {
        loginProvider.loginWithGoogle()
    }
}
