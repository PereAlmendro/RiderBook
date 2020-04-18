//
//  UserRepositoryTest.swift
//  RiderBookTests
//
//  Created by Pere Almendro on 18/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import XCTest
import RxTest
import RxSwift
@testable import RiderBook

class UserRepositoryTest: XCTestCase {

    var userRepository: UserRepositoryProtocol!
    
    override func setUpWithError() throws {
        let mockApiService = UserRepoApiServiceMock()
        userRepository = UserRepository(riderBookApiService: mockApiService)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}
