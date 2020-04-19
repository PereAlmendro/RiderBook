//
//  UserRepositoryTest.swift
//  RiderBookTests
//
//  Created by Pere Almendro on 19/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import XCTest
import RxTest

import RxSwift
@testable import RiderBook

class UserRepositoryTest: XCTestCase {

    var userRepository: UserRepositoryProtocol!
    var disposeBag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        let mockApiService = UserRepoApiServiceMock()
        userRepository = UserRepository(riderBookApiService: mockApiService)
    }

    override func tearDown() {
        super.tearDown()
        userRepository = nil
    }

    func testExample() throws {
        
    }

}
