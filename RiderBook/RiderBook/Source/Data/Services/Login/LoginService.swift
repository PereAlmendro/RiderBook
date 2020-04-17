//
//  LoginService.swift
//  RiderBook
//
//  Created by Pere Almendro on 08/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

protocol LoginServiceProtocol {
    func register(name: String, password: String,
                  email: String, imageURL: String)  -> Single<User?>
    func logIn(email: String, password: String, encodedPassword: Bool) -> Single<User?>
}

class LoginService: LoginServiceProtocol {
    
    // MARK: - Private properties
    
    private let userRepository: UserRepositoryProtocol
    private let localRepository: LocalRepositoryProtocol
    private var disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    
    init(userRepository: UserRepositoryProtocol,
         localRepository: LocalRepositoryProtocol) {
        self.userRepository = userRepository
        self.localRepository = localRepository
    }
    
    // MARK: - Public functions
    
    func register(name: String, password: String,
                  email: String, imageURL: String = "")  -> Single<User?> {
        return userRepository
            .createUser(name: name, password: password, email: email, imageURL: imageURL)
            .flatMap({ [weak self] (user) -> Single<User?> in
                guard
                    let user = user,
                    let userSaved = self?.localRepository.saveUser(user),
                    userSaved else { return Single.just(nil) }
                return Single.just(user)
            })
    }
    
    func logIn(email: String, password: String, encodedPassword: Bool = false) -> Single<User?> {
        return userRepository
            .login(email: email, password: password, encodedPassword: false)
            .flatMap({ [weak self] (user) -> Single<User?> in
                guard
                    let user = user,
                    let userSaved = self?.localRepository.saveUser(user),
                    userSaved else { return Single.just(nil) }
                return Single.just(user)
            })
    }
}
