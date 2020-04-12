
//
//  UserRepository.swift
//  RiderBook
//
//  Created by Pere Almendro on 12/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import RxSwift

protocol UserRepository {
    func createUser(name: String, password: String, email: String, imageURL: String) -> Single<User?>
    func login(email: String, password: String) -> Single<User?>
}

class UserRepositoryI: UserRepository {
    
    private let apiService: ApiService
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    func createUser(name: String, password: String, email: String, imageURL: String) -> Single<User?> {
        
        let userRequest = CreateUserRequest(name: name, password: password,
                                            image: imageURL, email: email)
        
        return apiService.loadRequest(UserTarget.createUser(userRequest),
                                      responseModel: UserResponse.self)
            .flatMap({ (result) -> Single<User?> in
                if let userData = try? result.get() {
                    // Make a factory to do this mappings ?
                    let user = User(userID: userData.id ?? 0,
                                    name: userData.name ?? "" ,
                                    photoUrl: userData.image ?? "" ,
                                    email: userData.email ?? "",
                                    authorization: userData.auth ?? "")
                    
                    return Single.just(user)
                } else {
                    return Single.just(nil)
                }
            }).asSingle()
    }
    
    func login(email: String, password: String) -> Single<User?> {
        
        let loginRequest = LoginRequest(email: email, password: password)
        
        return apiService.loadRequest(UserTarget.login(loginRequest),
                                      responseModel: UserResponse.self)
            .flatMap({ (result) -> Single<User?> in
                if let userData = try? result.get() {
                    // Make a factory to do this mappings ?
                    let user = User(userID: userData.id ?? 0,
                                    name: userData.name ?? "" ,
                                    photoUrl: userData.image ?? "" ,
                                    email: userData.email ?? "",
                                    authorization: userData.auth ?? "")
                    
                    return Single.just(user)
                } else {
                    return Single.just(nil)
                }
            }).asSingle()
    }
}
