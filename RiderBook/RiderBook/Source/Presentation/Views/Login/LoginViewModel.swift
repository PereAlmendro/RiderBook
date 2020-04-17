//
//  LoginViewModel.swift
//  RiderBook
//
//  Created by Pere Almendro on 06/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

class LoginViewModel: ObservableObject  {
    
    // MARK: - View properties
    
    // MARK: - Private properties
    
    private var loginService: LoginServiceProtocol
    private var coordinator: AppCoordinatorProtocol
    
    init(loginService: LoginServiceProtocol, coordinator: AppCoordinatorProtocol) {
        self.loginService = loginService
        self.coordinator = coordinator
    }
    
    func signUpAction() {
        // TODO: Attempt login
    }
    
    func guestAction() {
        // TODO: continue as guest
    }
}
