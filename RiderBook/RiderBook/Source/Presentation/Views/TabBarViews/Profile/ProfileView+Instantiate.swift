//
//  ProfileView+Instantiate.swift
//  RiderBook
//
//  Created by Pere Almendro on 20/12/20.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

extension ProfileView {
    static func instantiate() -> ProfileView {
        let apiProvider = APIProvider()
        let userRepository = UserRepository(apiProvider: apiProvider)
        let localRepository = LocalRepository()
        let loginService = LoginService(userRepository: userRepository, localRepository: localRepository)
        let userService = UserService(userRepository: userRepository, localRepository: localRepository)
        let profileViewModel = ProfileViewModel(loginService: loginService, userService: userService)
        return ProfileView(viewModel: profileViewModel)
    }
}
