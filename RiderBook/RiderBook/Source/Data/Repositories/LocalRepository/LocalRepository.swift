//
//  LocalRepository.swift
//  RiderBook
//
//  Created by Pere Almendro on 16/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

protocol LocalRepositoryProtocol {
    func getUser() -> User?
    func saveUser(_ user: User)
}

final class LocalRepository: LocalRepositoryProtocol {
    
    func getUser() -> User? {
        // TODO: Get user
        return nil
    }
    
    func saveUser(_ user: User) {
        // TODO: Get user
    }
}
