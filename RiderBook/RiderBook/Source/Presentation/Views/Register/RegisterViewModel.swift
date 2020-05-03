//
//  RegisterViewModel.swift
//  RiderBook
//
//  Created by Pere Almendro on 18/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class RegisterViewModel: ObservableObject  {
    
    // MARK: - View properties
    
    @Published var showAlert: Bool = false
    @Published var loading: Bool = false
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var repeatedPassword: String = ""
    var errorTitle = ""
    var errorMessage = ""
    
    // MARK: - Private properties
    
    private let loginService: LoginServiceProtocol
    private let coordinator: AppCoordinatorProtocol
    private var cancellables: [AnyCancellable?] = []
    
    // MARK: - Lifecycle
    
    init(loginService: LoginServiceProtocol,
         coordinator: AppCoordinatorProtocol) {
        self.loginService = loginService
        self.coordinator = coordinator
    }
    
    // MARK: - User Actions
    
    func registerAction() {
        
        guard validateCredentials() else { return }
        
        loading = true
        cancellables += [
            loginService
                .register(name: name, password: password, email: email)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { [weak self] (completion) in
                    switch completion {
                    case .failure(let error):
                        self?.showError(message: error.description())
                    default:
                        return
                    }
                    self?.loading = false
                }, receiveValue: { [weak self] (success) in
                    if success {
                        self?.coordinator.showHome()
                    } else {
                        self?.showError(message: "Something went wrong, try again later")
                    }
                })
        ]
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
        errorTitle = "error"
        errorMessage = message
        showAlert = true
    }
}
