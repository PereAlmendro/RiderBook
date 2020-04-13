//
//  ViewAssembly.swift
//  RiderBook
//
//  Created by Pere Almendro on 11/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import GoogleSignIn

class LoginAssembly {
    private let coordinator: AppCoordinator
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }

    func getView() -> LoginView {
        let riderBookApiService = RiderBookApiService()
        let userRepository = UserRepositoryI(riderBookApiService: riderBookApiService)
        let loginService = LoginServiceI(gidSignIn: GIDSignIn.sharedInstance(), userRepository: userRepository)
        let loginViewModel = LoginViewModel(loginService: loginService, coordinator: coordinator)
        return LoginView(viewModel: loginViewModel)
    }
}
