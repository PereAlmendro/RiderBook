//
//  SplashView+Instantiate.swift
//  RiderBook
//
//  Created by Pere Almendro on 20/12/20.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import SwiftUI

extension SplashView {
    static func instantiate() -> SplashView {
        let apiProvider = APIProvider()
        let userRepository = UserRepository(apiProvider: apiProvider)
        let localRepository = LocalRepository()
        let loginService = LoginService(userRepository: userRepository, localRepository: localRepository)
        let viewModel = SplashViewModel(loginService: loginService)
        return SplashView(viewModel: viewModel)
    }
}
