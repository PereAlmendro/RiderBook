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
    var loginResult: BehaviorSubject<Bool> { get }
}

class LoginService: LoginServiceProtocol {
    
    // MARK: - Rx bindings
    
    var loginResult: BehaviorSubject<Bool> = BehaviorSubject<Bool>(value: false)
    var registerResult: BehaviorSubject<Bool> = BehaviorSubject<Bool>(value: false)
    
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
    
    func register(name: String, password: String, email: String, imageURL: String = "") {
//        userRepository.createUser(name: name, password: password, email: email, imageURL: imageURL)
    }
    
    func logIn(email: String, password: String) {
//        userRepository.login(email: email, password: password)
    }
}
