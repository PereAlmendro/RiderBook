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
        return User(userId: userResponse.id,
                    name: userResponse.name,
                    photoUrl: "\(EnvironmentController.shared.urls.baseUrl)/user/profile-image?userId=\(userResponse.id)",
                    email: userResponse.email,
                    password: userResponse.password,
                    authorization: userResponse.auth)
    }
}
