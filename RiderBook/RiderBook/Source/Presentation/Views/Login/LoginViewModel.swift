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

protocol LoginViewModelProtocol: ObservableObject {
    func signInWithGoogle()
}

class LoginViewModel: LoginViewModelProtocol  {
    
    // MARK: - View properties
    
    var screenTitle = "Rider_book"
    var disposeBag = DisposeBag()
    
    // MARK: - Private properties
    
    private var loginService: LoginServiceProtocol
    private var coordinator: AppCoordinatorProtocol
    
    init(loginService: LoginServiceProtocol, coordinator: AppCoordinatorProtocol) {
        self.loginService = loginService
        self.coordinator = coordinator
        
        setuploginResultBinding()
        
        // TODO: Show loading
        self.loginService.attemptAutoLogin()
    }
    
    // MARK: - RxBindings
    
    func setuploginResultBinding() {
        loginService.loginResult.subscribe { [weak self] (event) in
            guard let (success, isAutoLogin) = event.element else { return }
            
            // TODO: remove loading
            if success {
                if (!isAutoLogin) {
                    // TODO: Show welcome message
                }
                self?.coordinator.openHomeAfterLogin()
            } else {
                // TODO: display error
            }
            
        }.disposed(by: disposeBag)
    }
    
    //MARK: - User actions
    
    func signInWithGoogle() {
        // TODO: Show loading
        loginService.signInWithGoogle()
    }
}
