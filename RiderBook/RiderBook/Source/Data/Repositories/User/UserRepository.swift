
//
//  UserRepositoryProtocol.swift
//  RiderBook
//
//  Created by Pere Almendro on 12/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import Combine

protocol UserRepositoryProtocol {
    func createUser(name: String, password: String, email: String) -> AnyPublisher<User?, RiderBookApiServiceError>
    func login(email: String, password: String, encodedPassword: Bool) -> AnyPublisher<User?, RiderBookApiServiceError>
}

class UserRepository: UserRepositoryProtocol {
    
    private let riderBookApiService: RiderBookApiServiceProtocol
    
    init(riderBookApiService: RiderBookApiServiceProtocol) {
        self.riderBookApiService = riderBookApiService
    }
    
    func createUser(name: String, password: String, email: String) -> AnyPublisher<User?, RiderBookApiServiceError> {
        let userRequest = CreateUserRequest(name: name, password: password, image: nil, email: email)
        
        return riderBookApiService
            .loadRequest(UserTarget.createUser(userRequest), responseModel: UserResponse.self)
            .map { (response) -> User? in
                guard let userResponse = response else {
                    return nil
                }
                return UserFactory.createUser(from: userResponse)
        }.eraseToAnyPublisher()
    }
    
    func login(email: String, password: String, encodedPassword: Bool) -> AnyPublisher<User?, RiderBookApiServiceError> {
        let loginRequest = LoginRequest(email: email, password: password, encodedPassword: encodedPassword)
        
        return riderBookApiService
            .loadRequest(UserTarget.login(loginRequest), responseModel: UserResponse.self)
            .map { (response) -> User? in
                guard let userResponse = response else {
                    return nil
                }
                return UserFactory.createUser(from: userResponse)
        }.eraseToAnyPublisher()
    }
}
