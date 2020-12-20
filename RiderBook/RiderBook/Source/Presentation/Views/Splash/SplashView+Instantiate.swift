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
    static func instantiate() -> UIHostingController<SplashView> {
        let riderBookApiService = RiderBookApiService()
        let userRepository = UserRepository(riderBookApiService: riderBookApiService)
        let localRepository = LocalRepository()
        let loginService = LoginService(userRepository: userRepository, localRepository: localRepository)
        let viewModel = SplashViewModel(loginService: loginService)
        let view = SplashView(viewModel: viewModel)
        return UIHostingController(rootView: view)
    }
}
