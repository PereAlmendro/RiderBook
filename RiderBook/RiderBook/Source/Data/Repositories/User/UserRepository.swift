
//
//  UserRepositoryProtocol.swift
//  RiderBook
//
//  Created by Pere Almendro on 12/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import RxSwift

protocol UserRepositoryProtocol {
    func createUser(name: String, password: String, email: String) -> Single<User?>
    func login(email: String, password: String, encodedPassword: Bool) -> Single<User?>
}

class UserRepository: UserRepositoryProtocol {
    
    private let riderBookApiService: RiderBookApiServiceProtocol
    
    init(riderBookApiService: RiderBookApiServiceProtocol) {
        self.riderBookApiService = riderBookApiService
    }
    
    func createUser(name: String, password: String, email: String) -> Single<User?> {
//        let userRequest = CreateUserRequest(name: name, password: password, image: nil, email: email)
        
        return Single.just(nil)
//        return riderBookApiService
//            .loadRequest(UserTarget.createUser(userRequest), responseModel: UserResponse.self)
//            .flatMap({ (result) -> Single<User?> in
//                guard let userData = try? result.get() else {
//                    return Single.just(nil)
//                }
//                return Single.just( UserFactory.createUser(from: userData) )
//            }).asSingle()
    }
    
    func login(email: String, password: String, encodedPassword: Bool = false) -> Single<User?> {
        
//        let loginRequest = LoginRequest(email: email, password: password, encodedPassword: encodedPassword)
        
        return Single.just(nil)
//        return riderBookApiService
//            .loadRequest(UserTarget.login(loginRequest), responseModel: UserResponse.self)
//            .flatMap({ (result) -> Single<User?> in
//                guard let userData = try? result.get() else {
//                    return Single.just(nil)
//                }
//                return Single.just( UserFactory.createUser(from: userData) )
//            }).asSingle()
    }
}
