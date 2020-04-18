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
    
    @Published var loading: Bool = false
    @Published var email: String = ""
    @Published var password: String = ""
    
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
                if let error = error as? RiderBookApiServiceError,
                    let errorMessage = error.getError().message {
                    self?.showError(message: errorMessage)
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
        
        if !validate(email: email) {
            showError(message: "This email is not valid")
            credentialsValid = false
        } else if !validate(password: password) {
            showError(message: "Password must be longer than 4 characters")
            credentialsValid = false
        }
        
        return credentialsValid
    }
    
    private func validate(email: String) -> Bool {
        return email.contains("@") && email.contains(".")
    }
    
    private func validate(password: String) -> Bool {
        return password.count >= 4
    }
    
    private func showError(message: String) {
        // TODO: Show error
    }
}
