//
//  LocalRepositoryTest.swift
//  RiderBookTests
//
//  Created by Pere Almendro on 18/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import XCTest
@testable import RiderBook

final class LocalRepositoryTest: XCTestCase {
    private var localRepository: LocalRepositoryProtocol!
    
    override func setUpWithError() throws {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        localRepository = LocalRepository(context: context)
    }

    override func tearDownWithError() throws {
        localRepository = nil
    }

    func testGetSaveUser() throws {
        let user = User(userId: 0, name: "test",
                        photoUrl: "", email: "test@test.com",
                        password: "test", authorization: "authorizationTokenValidForOneWeeek")
        
        localRepository.saveUser(user)
        let persistingUser = localRepository.getUser()
        
        XCTAssertTrue(
            persistingUser?.email == user.email
            && persistingUser?.password == user.password
            && persistingUser?.authorization == user.authorization
        )
    }

}
