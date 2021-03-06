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
    func attemptAutologin() -> AnyPublisher<Bool, RiderBookError>?
    func register(name: String, password: String, email: String) -> AnyPublisher<Bool, RiderBookError>
    func logIn(email: String, password: String, encodedPassword: Bool) -> AnyPublisher<Bool, RiderBookError>
    func logOut() -> Bool
}

final class LoginService: LoginServiceProtocol {
    
    // MARK: - Private properties
    
    private let userRepository: UserRepositoryProtocol
    private let localRepository: LocalRepositoryProtocol
    
    // MARK: - Lifecycle
    
    init(userRepository: UserRepositoryProtocol,
         localRepository: LocalRepositoryProtocol) {
        self.userRepository = userRepository
        self.localRepository = localRepository
    }
    
    // MARK: - LoginServiceProtocol
    
    func attemptAutologin() -> AnyPublisher<Bool, RiderBookError>? {
        guard let user = localRepository.getUser() else {
            return nil
        }
        return logIn(email: user.email, password: user.password, encodedPassword: true)
    }
    
    func register(name: String, password: String, email: String) -> AnyPublisher<Bool, RiderBookError> {
        return userRepository
            .createUser(name: name, password: password, email: email)
            .map { [weak self] (user) -> Bool in
                guard let user = user,
                    let userSaved = self?.localRepository.saveUser(user) else {
                        return false
                }
                return userSaved
        }.eraseToAnyPublisher()
    }
    
    func logIn(email: String, password: String, encodedPassword: Bool) -> AnyPublisher<Bool, RiderBookError> {
        return userRepository
            .login(email: email, password: password, encodedPassword: encodedPassword)
            .map { [weak self] (user) -> Bool in
                guard let user = user,
                    let userSaved = self?.localRepository.saveUser(user) else {
                    return false
                }
                return userSaved
        }.eraseToAnyPublisher()
    }
    
    func logOut() -> Bool {
        return localRepository.deleteSavedUser()
    }
}
