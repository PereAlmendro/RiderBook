//
//  UserRepositoryTest.swift
//  RiderBookTests
//
//  Created by Pere Almendro on 11/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import XCTest
@testable import RiderBook

class UserRepositoryTest: XCTestCase {
    
    private var userRepository: UserRepository!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let riderBookApiService = RiderBookApiService()
        userRepository = UserRepositoryI(riderBookApiService: riderBookApiService)
    }
    
    func testLoginSuccess() throws {
        let expectation = XCTestExpectation(description: "Login sucess")
        _ = userRepository.login(email: "test@test.com", password: "test")
            .subscribe(onSuccess: { (user) in
                if user != nil, let auth = user?.authorization, auth.count > 0 {
                    expectation.fulfill()
                }
            })
        wait(for: [expectation], timeout: 10)
    }
    
    func testLoginFailure() throws {
        let expectation = XCTestExpectation(description: "Login Failure unexisting user")
        _ = userRepository.login(email: "Invalid@Invalid.com", password: "Invalid")
            .subscribe(onError: { (error) in
                guard let error = error as? RiderBookApiServiceError else { return }
                if error.getError().message == "Invalid credentials" {
                    expectation.fulfill()
                }
            })
        wait(for: [expectation], timeout: 10)
    }
}
