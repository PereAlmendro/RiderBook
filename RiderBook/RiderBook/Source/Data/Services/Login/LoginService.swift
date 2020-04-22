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
    func attemptAutologin() -> Single<Bool>
    func register(name: String, password: String, email: String)  -> Single<Bool>
    func logIn(email: String, password: String, encodedPassword: Bool) -> Single<Bool>
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
    
    func register(name: String, password: String, email: String)  -> Single<Bool> {
        return Single.just(true)
//        return userRepository
//            .createUser(name: name, password: password, email: email)
//            .flatMap({ [weak self] (user) -> Single<Bool> in
//                guard
//                    let user = user,
//                    let userSaved = self?.localRepository.saveUser(user),
//                    userSaved else { return Single.just(false) }
//                return Single.just(userSaved)
//            })
    }
    
    func logIn(email: String, password: String, encodedPassword: Bool = false) -> Single<Bool> {
        return Single.just(true)
//        return userRepository
//            .login(email: email, password: password, encodedPassword: encodedPassword)
//            .flatMap({ [weak self] (user) -> Single<Bool> in
//                guard
//                    let user = user,
//                    let userSaved = self?.localRepository.saveUser(user),
//                    userSaved else { return Single.just(false) }
//                return Single.just(userSaved)
//            })
    }
    
    func attemptAutologin() -> Single<Bool> {
        guard let user = localRepository.getUser() else {
            return Single.just(false)
        }
        return logIn(email: user.email, password: user.password, encodedPassword: true)
    }
}
