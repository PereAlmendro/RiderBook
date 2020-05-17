//
//  UserService.swift
//  RiderBook
//
//  Created by Pere Almendro on 17/05/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import Combine

protocol UserServiceProtocol {
    
}


final class UserService: UserServiceProtocol {
    
    // MARK: - Private properties
    
    private let userRepository: UserRepositoryProtocol
    private let localRepository: LocalRepositoryProtocol
    
    // MARK: - Lifecycle
    
    init(userRepository: UserRepositoryProtocol,
         localRepository: LocalRepositoryProtocol) {
        self.userRepository = userRepository
        self.localRepository = localRepository
    }
    
    // TODO: Edit user
    // TODO: Upload image
    // TODO: Delete user
}
