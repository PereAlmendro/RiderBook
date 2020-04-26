//
//  UserRepositoryMocks.swift
//  RiderBookTests
//
//  Created by Pere Almendro on 24/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import Combine
@testable import RiderBook

final class UserRepositorySuccessMock: UserRepositoryProtocol {
    func createUser(name: String, password: String, email: String) -> AnyPublisher<User?, RiderBookError> {
        return Result<Int, Error>.Publisher(0)
            .map({ (result) -> User? in
                return User(userId: 11, name: "test",
                            photoUrl: "", email: "test@test.com",
                            password: "test", authorization: "adasdasdsadasdsadsa")
            })
            .mapError({ error in RiderBookError.badRequest(error) })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func login(email: String, password: String, encodedPassword: Bool) -> AnyPublisher<User?, RiderBookError> {
        return Result<Int, Error>.Publisher(0)
            .map({ (result) -> User? in
                return User(userId: 11, name: "test",
                            photoUrl: "", email: "test@test.com",
                            password: "test", authorization: "adasdasdsadasdsadsa")
            })
            .mapError({ error in RiderBookError.badRequest(error) })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

final class UserRepositoryNilMock: UserRepositoryProtocol {
    func createUser(name: String, password: String, email: String) -> AnyPublisher<User?, RiderBookError> {
        return Result<Int, Error>.Publisher(0)
            .map({ (result) -> User? in
                return nil
            })
            .mapError({ error in RiderBookError.badRequest(error) })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func login(email: String, password: String, encodedPassword: Bool) -> AnyPublisher<User?, RiderBookError> {
        return Result<Int, Error>.Publisher(0)
            .map({ (result) -> User? in
                return nil
            })
            .mapError({ error in RiderBookError.badRequest(error) })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
