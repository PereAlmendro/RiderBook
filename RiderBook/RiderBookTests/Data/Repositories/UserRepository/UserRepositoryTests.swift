//
//  UserRepositoryTests.swift
//  RiderBookTests
//
//  Created by Pere Almendro on 22/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import XCTest
import Combine
@testable import RiderBook

class UserRepositoryTest: XCTestCase {
    
    var userRepository: UserRepositoryProtocol!
    private var anyCancellables: [AnyCancellable] = []
    
    override func tearDownWithError() throws {
        userRepository = nil
    }
    
    func testLoginSuccess() {
        
        let apiService = UserRepositoryMockSuccessApiService()
        userRepository = UserRepository(riderBookApiService: apiService)
        
        let expectation = XCTestExpectation()
        
        let request = userRepository
            .login(email: "test@test.com", password: "test", encodedPassword: false)
            .sink(receiveCompletion: { print($0) }) { (user) in
                if user?.email == "test@test.com" {
                    expectation.fulfill()
                }
        }
        
        anyCancellables += [
            request
        ]
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testRegisterSuccess() {
        
        let apiService = UserRepositoryMockSuccessApiService()
        userRepository = UserRepository(riderBookApiService: apiService)
        
        let expectation = XCTestExpectation()
        
        let request = userRepository
            .createUser(name: "test", password: "test", email: "test@test.com")
            .sink(receiveCompletion: { print($0) }) { (user) in
                if user?.email == "test@test.com" {
                    expectation.fulfill()
                }
        }
        
        anyCancellables += [
            request
        ]
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testLoginNilUser() {
        
        let apiService = UserRepositoryMockNilUserApiService()
        userRepository = UserRepository(riderBookApiService: apiService)
        
        let expectation = XCTestExpectation()
        
        let request = userRepository
            .login(email: "test@test.com", password: "test", encodedPassword: false)
            .sink(receiveCompletion: { print($0) }) { (user) in
                if user == nil {
                    expectation.fulfill()
                }
        }
        
        anyCancellables += [
            request
        ]
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testRegisterNilUser() {
        
        let apiService = UserRepositoryMockNilUserApiService()
        userRepository = UserRepository(riderBookApiService: apiService)
        
        let expectation = XCTestExpectation()
        
        let request = userRepository
            .createUser(name: "test", password: "test", email: "test@test.com")
            .sink(receiveCompletion: { print($0) }) { (user) in
                if user == nil {
                    expectation.fulfill()
                }
        }
        
        anyCancellables += [
            request
        ]
        
        wait(for: [expectation], timeout: 10)
    }
    
}
