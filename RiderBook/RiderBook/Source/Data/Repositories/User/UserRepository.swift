
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
    func createUser(name: String, password: String, email: String, imageURL: String) -> Single<User?>
    func login(email: String, password: String, encodedPassword: Bool) -> Single<User?>
}

class UserRepository: UserRepositoryProtocol {
    
    private let riderBookApiService: RiderBookApiService
    
    init(riderBookApiService: RiderBookApiService) {
        self.riderBookApiService = riderBookApiService
    }
    
    func createUser(name: String, password: String, email: String, imageURL: String) -> Single<User?> {
        
        let userRequest = CreateUserRequest(name: name, password: password,
                                            image: imageURL, email: email)
        
        return riderBookApiService
            .loadRequest(UserTarget.createUser(userRequest), responseModel: UserResponse.self)
            .flatMap({ (result) -> Single<User?> in
                if let userData = try? result.get() {
                    return Single.just(
                        UserFactory.createUser(from: userData)
                    )
                } else {
                    return Single.just(nil)
                }
            }).asSingle()
    }
    
    func login(email: String, password: String, encodedPassword: Bool = false) -> Single<User?> {
        
        let loginRequest = LoginRequest(email: email, password: password,
                                        encodedPassword: encodedPassword)
        
        return riderBookApiService
            .loadRequest(UserTarget.login(loginRequest), responseModel: UserResponse.self)
            .flatMap({ (result) -> Single<User?> in
                if let userData = try? result.get() {
                    return Single.just(
                        UserFactory.createUser(from: userData)
                    )
                } else {
                    return Single.just(nil)
                }
            }).asSingle()
    }
}
