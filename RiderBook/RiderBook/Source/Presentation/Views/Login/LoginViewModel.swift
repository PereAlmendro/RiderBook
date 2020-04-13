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
import RxSwift

class LoginViewModel: ObservableObject  {
    
    // MARK: - View properties
    
    var screenTitle = "Rider_book"
    var disposeBag = DisposeBag()
    
    // MARK: - Private properties
    
    private var loginService: LoginService
    private var coordinator: AppCoordinator
    
    init(loginService: LoginService, coordinator: AppCoordinator) {
        self.loginService = loginService
        self.coordinator = coordinator
    }
    
    //MARK: - User actions
    
    func loginWithGoogle() {
        loginService.loginWithGoogle() 
    }
    
    func loginWithFacebook() {
        // TODO
    }
    
}
