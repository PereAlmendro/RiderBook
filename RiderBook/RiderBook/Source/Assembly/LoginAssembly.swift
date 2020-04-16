//
//  ViewAssembly.swift
//  RiderBook
//
//  Created by Pere Almendro on 11/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import UIKit

class LoginAssembly {
    private let coordinator: AppCoordinatorProtocol
    
    init(coordinator: AppCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func getView() -> LoginView {
        let riderBookApiService = RiderBookApiService()
        let userRepository = UserRepository(riderBookApiService: riderBookApiService)
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let localRepository = LocalRepository(context: context)
        let loginService = LoginService(userRepository: userRepository,
                                        localRepository: localRepository)
        let loginViewModel = LoginViewModel(loginService: loginService, coordinator: coordinator)
        return LoginView(viewModel: loginViewModel)
    }
}
