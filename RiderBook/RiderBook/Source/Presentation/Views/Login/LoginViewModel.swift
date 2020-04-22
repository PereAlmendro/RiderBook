//
//  LoginViewModel.swift
//  RiderBook
//
//  Created by Pere Almendro on 06/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import SwiftUI
import RxSwift

class LoginViewModel: ObservableObject  {
    
    // MARK: - View properties
    
    @Published var showAlert: Bool = false
    @Published var loading: Bool = false
    @Published var email: String = ""
    @Published var password: String = ""
    var errorTitle = "Error"
    var errorMessage = ""
    
    // MARK: - Private properties
    
    private var loginService: LoginServiceProtocol
    private var coordinator: AppCoordinatorProtocol
    private var disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    
    init(loginService: LoginServiceProtocol, coordinator: AppCoordinatorProtocol) {
        self.loginService = loginService
        self.coordinator = coordinator
    }
    
    // MARK: - User Actions
    
    func loginAction() {
        guard validateCredentials() else { return }
        
        loading = true
        loginService
            .logIn(email: email, password: password, encodedPassword: false)
            .subscribeOn(SerialDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] (success) in
                
                self?.loading = false
                if success {
                    self?.coordinator.showHome()
                } else {
                    self?.showError(message: "Something went wrong, try again later")
                }
            
            }) { [weak self] (error) in
                
                self?.loading = false
                if let error = error as? RiderBookApiServiceError {
                    self?.showError(message: error.description())
                } else {
                    self?.showError(message: "Something went wrong, try again later")
                }
                
        }.disposed(by: disposeBag)
    }
    
    func registerAction() {
        coordinator.showRegister()
    }
    
    // MARK: - Private methods
    
    private func validateCredentials() -> Bool {
        var credentialsValid = true
        
        if !email.isValidEmail() {
            showError(message: "This email is not valid")
            credentialsValid = false
        } else if !password.isValidPassword() {
            showError(message: "Password must be longer than 4 characters")
            credentialsValid = false
        }
        
        return credentialsValid
    }
    
    private func showError(message: String) {
        errorMessage = message
        showAlert = true
    }
}
