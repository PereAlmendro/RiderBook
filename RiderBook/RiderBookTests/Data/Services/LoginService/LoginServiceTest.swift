//
//  LoginServiceTest.swift
//  RiderBookTests
//
//  Created by Pere Almendro on 23/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import XCTest
import Combine
@testable import RiderBook

class LoginServiceTest: XCTestCase {
    
    private var loginService: LoginServiceProtocol!
    private var anyCancellables: [AnyCancellable?] = []

    override func setUpWithError() throws {
        let userRepository = UserRepositorySuccessMock()
        let localRepository = MockLocalRepositorySuccess()
        let loginService = LoginService(userRepository: userRepository,
                                        localRepository: localRepository)
        self.loginService = loginService
    }
    
    private func setupSuccessMocks() {
        self.loginService = nil
        
        let userRepository = UserRepositorySuccessMock()
        let localRepository = MockLocalRepositorySuccess()
        let loginService = LoginService(userRepository: userRepository,
                                        localRepository: localRepository)
        self.loginService = loginService
    }
    
    private func setupFailureMocks() {
        self.loginService = nil
        
        let userRepository = UserRepositoryNilMock()
        let localRepository = MockLocalRepositoryNil()
        let loginService = LoginService(userRepository: userRepository,
                                        localRepository: localRepository)
        self.loginService = loginService
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAutologin() throws {
        
        setupSuccessMocks()
        
        let expectation = XCTestExpectation()
        
        let request = loginService.register(name: "test", password: "test", email: "test@test.com")
            .sink(receiveCompletion: { print($0) }) { (success) in
                if success {
                    expectation.fulfill()
                }
        }
        
        anyCancellables += [
            request
        ]
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testlogin() throws {
        
        setupSuccessMocks()
        
        let expectation = XCTestExpectation()
        
        let request = loginService.logIn(email: "test@test.com", password: "test", encodedPassword: false)
            .sink(receiveCompletion: { print($0) }) { (success) in
                if success {
                    expectation.fulfill()
                }
        }
        
        anyCancellables += [
            request
        ]
        
        wait(for: [expectation], timeout: 10)
    }

    func testReister() throws {
        
        setupSuccessMocks()
        
        let expectation = XCTestExpectation()
        
        let request = loginService.attemptAutologin()?
            .sink(receiveCompletion: { print($0) }) { (success) in
                if success {
                    expectation.fulfill()
                }
        }
        
        anyCancellables += [
            request
        ]
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testAutologinError() throws {
        
        setupFailureMocks()
        
        let expectation = XCTestExpectation()
        
        let request = loginService.register(name: "test", password: "test", email: "test@test.com")
            .sink(receiveCompletion: { print($0) }) { (success) in
                if !success {
                    expectation.fulfill()
                }
        }
        
        anyCancellables += [
            request
        ]
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testloginError() throws {
        
        setupFailureMocks()
        
        let expectation = XCTestExpectation()
        
        let request = loginService.logIn(email: "test@test.com", password: "test", encodedPassword: false)
            .sink(receiveCompletion: { print($0) }) { (success) in
                if !success {
                    expectation.fulfill()
                }
        }
        
        anyCancellables += [
            request
        ]
        
        wait(for: [expectation], timeout: 10)
    }

    func testReisterError() throws {
        
        setupFailureMocks()
        
        let expectation = XCTestExpectation()
        
        if let request = loginService.attemptAutologin() {
            anyCancellables += [
                request.sink(receiveCompletion: { print($0) },
                             receiveValue: { print($0) } )
            ]
        } else {
            expectation.fulfill()
        }
            
        wait(for: [expectation], timeout: 10)
    }
}


