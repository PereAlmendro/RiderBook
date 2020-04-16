//
//  UserFactory.swift
//  RiderBook
//
//  Created by Pere Almendro on 16/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

protocol UserFactoryProtocol {
    static func createUser(from userResponse: UserResponse) -> User?
}

final class UserFactory: UserFactoryProtocol {
    static func createUser(from userResponse: UserResponse) -> User? {
        return User(userID: userResponse.id,
                    name: userResponse.name,
                    photoUrl: userResponse.image ?? "",
                    email: userResponse.email,
                    authorization: userResponse.auth)
    }
}
