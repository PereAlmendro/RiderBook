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

final class LoginViewModel: ObservableObject {

    @Published var navigation: Navigation? = nil
    enum Navigation {
        case home
        case register
    }

    @Published var loading: Bool = false
    @Published var email: String = ""
    @Published var password: String = ""

    @Published var showAlert: Bool = false
    var errorTitle = "Error"
    var errorMessage = ""

    private let loginService: LoginServiceProtocol
    private var cancellables: [AnyCancellable?] = []

    init(loginService: LoginServiceProtocol) {
        self.loginService = loginService
    }

    func loginAction() {
        guard validateCredentials() else { return }
        
        loading = true
        let loginCancellable = loginService
            .logIn(email: email, password: password)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] (completion) in
                self?.loading = false
                switch completion {
                case .failure(let error):
                    self?.showError(message: error.localizedDescription)
                default:
                    return
                }
            },
            receiveValue: { [weak self] (success) in
                if success {
                    self?.navigation = .home
                } else {
                    self?.showError(message: "Something went wrong, try again later")
                }
            })

        cancellables.append(loginCancellable)
    }
    
    func registerAction() {
        self.navigation = .register
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
