//
//  UserService.swift
//  RiderBook
//
//  Created by Pere Almendro on 17/05/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import UIKit
import Combine

protocol UserServiceProtocol {
    func getUser() -> User?
    func uploadImage(image: UIImage) -> AnyPublisher<Bool, APIProviderError>
    func deleteUser(_ user: User) -> AnyPublisher<Bool, APIProviderError>
}

final class UserService {

    private let userRepository: UserRepositoryProtocol
    private let localRepository: LocalRepositoryProtocol
    private var userAuth: String {
        return localRepository.getUser()?.authorization ?? ""
    }

    init(userRepository: UserRepositoryProtocol,
         localRepository: LocalRepositoryProtocol) {
        self.userRepository = userRepository
        self.localRepository = localRepository
    }
}

extension UserService: UserServiceProtocol {

    func getUser() -> User? {
        return localRepository.getUser()
    }
    
    func deleteUser(_ user: User) -> AnyPublisher<Bool, APIProviderError> {
        return userRepository.deleteUser(user, userAuth: userAuth)
    }
    
    func uploadImage(image: UIImage) -> AnyPublisher<Bool, APIProviderError> {
        return userRepository.uploadImage(imageBase64: image.toBase64(),
                                          userAuth: userAuth)
    }
    
    // TODO: - Edit user
}
