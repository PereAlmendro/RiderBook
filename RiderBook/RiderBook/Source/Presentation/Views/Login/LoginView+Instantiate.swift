//
//  LoginViewCoordinator.swift
//  RiderBook
//
//  Created by Pere Almendro on 18/12/20.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

extension LoginView {
    static func instantiate() -> LoginView {
        let apiService = APIProvider()
        let userRepository = UserRepository(apiProvider: apiService)
        let localRepository = LocalRepository()
        let loginService = LoginService(userRepository: userRepository, localRepository: localRepository)
        let loginViewModel = LoginViewModel(loginService: loginService)
        return LoginView(viewModel: loginViewModel)
    }
}
