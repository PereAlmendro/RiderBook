
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
    func createUser(name: String, password: String, email: String) -> AnyPublisher<User?, RiderBookError>
    func login(email: String, password: String, encodedPassword: Bool) -> AnyPublisher<User?, RiderBookError>
    func uploadImage(imageBase64: String, userAuth: String) -> AnyPublisher<Bool, RiderBookError>
    func deleteUser(_ user: User, userAuth: String) -> AnyPublisher<Bool, RiderBookError>
}

final class UserRepository {

    private let riderBookApiService: RiderBookApiServiceProtocol

    init(riderBookApiService: RiderBookApiServiceProtocol) {
        self.riderBookApiService = riderBookApiService
    }
}

extension UserRepository: UserRepositoryProtocol {
    
    func createUser(name: String, password: String, email: String) -> AnyPublisher<User?, RiderBookError> {
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
    
    func login(email: String, password: String, encodedPassword: Bool) -> AnyPublisher<User?, RiderBookError> {
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
    
    func uploadImage(imageBase64: String, userAuth: String) -> AnyPublisher<Bool, RiderBookError> {
        let uploadImageRequest =  UploadImageRequest(image: imageBase64,
                                                     authorization: userAuth)
        return riderBookApiService
            .loadRequest(UserTarget.uploadImage(uploadImageRequest), responseModel: RiderBookServiceSuccessResponse.self)
            .map { (response) -> Bool in
                return response?.success ?? false
        }.eraseToAnyPublisher()
    }
    
    func deleteUser(_ user: User, userAuth: String) -> AnyPublisher<Bool, RiderBookError> {
        let deleteUserRequest =  DeleteUserRequest(userId: user.userId,
                                                   authorization: userAuth)
        return riderBookApiService
            .loadRequest(UserTarget.deleteUser(deleteUserRequest), responseModel: RiderBookServiceSuccessResponse.self)
            .map { (response) -> Bool in
                return response?.success ?? false
        }.eraseToAnyPublisher()
    }
}
