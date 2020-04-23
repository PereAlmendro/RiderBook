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
    
    let loginService: LoginServiceProtocol!

    override func setUpWithError() throws {
        
        let userRepository = UserRepository(riderBookApiService: riderBookApiService)
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let localRepository = LocalRepository(context: context)
        let loginService = LoginService(userRepository: userRepository,
                                        localRepository: localRepository)
        self.loginService = loginService
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAutologin() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testlogin() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testReister() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
}


class userRepositoryMock: UserRepositoryProtocol {
    
}
