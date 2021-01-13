//
//  LoginService.swift
//  RiderBook
//
//  Created by Pere Almendro on 08/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import UIKit
import Combine

protocol LoginServiceProtocol {
    func attemptAutologin() -> AnyPublisher<Bool, APIProviderError>?
    func register(name: String, password: String, email: String) -> AnyPublisher<Bool, APIProviderError>
    func logIn(email: String, password: String, encodedPassword: Bool) -> AnyPublisher<Bool, APIProviderError>
    func logOut()
}

extension LoginServiceProtocol {
    func logIn(email: String, password: String, encodedPassword: Bool = false) -> AnyPublisher<Bool, APIProviderError> {
        return logIn(email: email, password: password, encodedPassword: encodedPassword)
    }
}

final class LoginService {

    private let userRepository: UserRepositoryProtocol
    private let localRepository: LocalRepositoryProtocol

    init(userRepository: UserRepositoryProtocol,
         localRepository: LocalRepositoryProtocol) {
        self.userRepository = userRepository
        self.localRepository = localRepository
    }
}

extension LoginService: LoginServiceProtocol {
    
    func attemptAutologin() -> AnyPublisher<Bool, APIProviderError>? {
        guard let user = localRepository.getUser() else {
            return nil
        }
        return logIn(email: user.email, password: user.password, encodedPassword: true)
    }
    
    func register(name: String, password: String, email: String) -> AnyPublisher<Bool, APIProviderError> {
        return userRepository
            .createUser(name: name, password: password, email: email)
            .map { [weak self] (user) -> Bool in
                guard let user = user else {
                        return false
                }
                self?.localRepository.saveUser(user)
                return true
        }.eraseToAnyPublisher()
    }
    
    func logIn(email: String, password: String, encodedPassword: Bool = false) -> AnyPublisher<Bool, APIProviderError> {
        return userRepository
            .login(email: email, password: password, encodedPassword: encodedPassword)
            .map { [weak self] (user) -> Bool in
                guard let user = user else {
                    return false
                }
                self?.localRepository.saveUser(user)
                return true
        }.eraseToAnyPublisher()
    }
    
    func logOut() {
        localRepository.deleteSavedUser()
    }
}
