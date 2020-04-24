//
//  MockLocalRepository.swift
//  RiderBookTests
//
//  Created by Pere Almendro on 24/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
@testable import RiderBook

class MockLocalRepositorySuccess: LocalRepositoryProtocol {
    func getUser() -> User? {
        return User(userId: 11, name: "test",
                    photoUrl: "", email: "test@test.com",
                    password: "test", authorization: "")
    }
    
    func saveUser(_ user: User) -> Bool {
        return true
    }
}

class MockLocalRepositoryNil: LocalRepositoryProtocol {
    func getUser() -> User? {
        return nil
    }
    func saveUser(_ user: User) -> Bool {
        return false
    }
}

