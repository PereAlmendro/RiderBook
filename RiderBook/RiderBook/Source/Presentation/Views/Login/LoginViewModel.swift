//
//  LoginViewModel.swift
//  RiderBook
//
//  Created by Pere Almendro on 06/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class LoginViewModel: ObservableObject  {
    
    // MARK: - View properties
    
    @Published var showAlert: Bool = false
    @Published var loading: Bool = false
    @Published var email: String = ""
    @Published var password: String = ""
    var errorTitle = "Error"
    var errorMessage = ""
    
    // MARK: - Private properties
    
    private let loginService: LoginServiceProtocol
    private let coordinator: AppCoordinatorProtocol
    private var cancellables: [AnyCancellable?] = []
    
    // MARK: - Lifecycle
    
    init(loginService: LoginServiceProtocol, coordinator: AppCoordinatorProtocol) {
        self.loginService = loginService
        self.coordinator = coordinator
    }
    
    // MARK: - User Actions
    
    func loginAction() {
        guard validateCredentials() else { return }
        
        loading = true
        cancellables += [
            loginService
                .logIn(email: email, password: password, encodedPassword: false)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { [weak self] (completion) in
                    switch completion {
                    case .failure(let error):
                        self?.showError(message: error.description())
                    default:
                        return
                    }
                    self?.loading = false
                    },
                      receiveValue: { [weak self] (success) in
                        if success {
                            self?.coordinator.showHome()
                        } else {
                            self?.showError(message: "Something went wrong, try again later")
                        }
                })
        ]
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
