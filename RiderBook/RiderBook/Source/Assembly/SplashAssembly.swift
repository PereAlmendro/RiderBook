//
//  SplashAssembly.swift
//  RiderBook
//
//  Created by Pere Almendro on 18/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import UIKit

class SplashAssembly {
    private let coordinator: AppCoordinatorProtocol
    
    init(coordinator: AppCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func getView() -> SplashView {
        let riderBookApiService = RiderBookApiService()
        let userRepository = UserRepository(riderBookApiService: riderBookApiService)
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let localRepository = LocalRepository(context: context)
        let loginService = LoginService(userRepository: userRepository, localRepository: localRepository)
        let splashViewModel = SplashViewModel(loginService: loginService, coordinator: coordinator)
        return SplashView(viewModel: splashViewModel)
    }
}
