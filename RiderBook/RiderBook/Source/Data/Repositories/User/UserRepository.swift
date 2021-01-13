
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
    func createUser(name: String, password: String, email: String) -> AnyPublisher<User?, APIProviderError>
    func login(email: String, password: String, encodedPassword: Bool) -> AnyPublisher<User?, APIProviderError>
    func uploadImage(imageBase64: String, userAuth: String) -> AnyPublisher<Bool, APIProviderError>
    func deleteUser(_ user: User, userAuth: String) -> AnyPublisher<Bool, APIProviderError>
}

final class UserRepository {

    private let apiProvider: APIProvider

    init(apiProvider: APIProvider) {
        self.apiProvider = apiProvider
    }
}

extension UserRepository: UserRepositoryProtocol {
    
    func createUser(name: String, password: String, email: String) -> AnyPublisher<User?, APIProviderError> {
        let userRequest = CreateUserRequest(name: name, password: password, image: nil, email: email)
        return apiProvider
            .loadRequest(UserTarget.createUser(userRequest), responseModel: UserResponse.self)
            .map { (response) -> User? in
                guard let userResponse = response else {
                    return nil
                }
                return UserFactory.createUser(from: userResponse)
        }.eraseToAnyPublisher()
    }
    
    func login(email: String, password: String, encodedPassword: Bool) -> AnyPublisher<User?, APIProviderError> {
        let loginRequest = LoginRequest(email: email, password: password, encodedPassword: encodedPassword)
        return apiProvider
            .loadRequest(UserTarget.login(loginRequest), responseModel: UserResponse.self)
            .map { (response) -> User? in
                guard let userResponse = response else {
                    return nil
                }
                return UserFactory.createUser(from: userResponse)
        }.eraseToAnyPublisher()
    }
    
    func uploadImage(imageBase64: String, userAuth: String) -> AnyPublisher<Bool, APIProviderError> {
        let uploadImageRequest =  UploadImageRequest(image: imageBase64,
                                                     authorization: userAuth)
        return apiProvider
            .loadRequest(UserTarget.uploadImage(uploadImageRequest), responseModel: RiderBookServiceSuccessResponse.self)
            .map { (response) -> Bool in
                return response?.success ?? false
        }.eraseToAnyPublisher()
    }
    
    func deleteUser(_ user: User, userAuth: String) -> AnyPublisher<Bool, APIProviderError> {
        let deleteUserRequest =  DeleteUserRequest(userId: user.userId,
                                                   authorization: userAuth)
        return apiProvider
            .loadRequest(UserTarget.deleteUser(deleteUserRequest), responseModel: RiderBookServiceSuccessResponse.self)
            .map { (response) -> Bool in
                return response?.success ?? false
        }.eraseToAnyPublisher()
    }
}
