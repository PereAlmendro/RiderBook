//
//  RegisterViewModel.swift
//  RiderBook
//
//  Created by Pere Almendro on 18/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import SwiftUI
import RxSwift

class RegisterViewModel: ObservableObject  {
    
    // MARK: - View properties
    
    @Published var loading: Bool = false
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var repeatedPassword: String = ""
    
    // MARK: - Private properties
    
    private var loginService: LoginServiceProtocol
    private var coordinator: AppCoordinatorProtocol
    private var disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    
    init(loginService: LoginServiceProtocol,
         coordinator: AppCoordinatorProtocol) {
        self.loginService = loginService
        self.coordinator = coordinator
    }
    
    // MARK: - User Actions
    
    func registerAction() {
        
        guard validateCredentials() else { return }
        
        loginService
            .register(name: name, password: password, email: email)
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
    
    // MARK: - Private functions
    
    private func validateCredentials() -> Bool {
        var credentialsValid = true
        
        if name.count < 1 {
            showError(message: "This name is not valid")
            credentialsValid = false
        } else if !email.isValidEmail() {
            showError(message: "This email is not valid")
            credentialsValid = false
        } else if !password.isValidPassword() {
            showError(message: "Password must be longer than 4 characters")
            credentialsValid = false
        } else if password != repeatedPassword {
            showError(message: "Passwords don't match")
            credentialsValid = false
        }
        
        return credentialsValid
    }
    
    private func showError(message: String) {
        // TODO: Show error
    }
}
