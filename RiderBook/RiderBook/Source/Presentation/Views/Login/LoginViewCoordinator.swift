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

final class LoginViewCoordinator: CoordinatorProtocol {
    var childCoordinators: [CoordinatorProtocol]
    var navigationController: UINavigationController

    private var tabView: TabBarView?

    init(childCoordinators: [CoordinatorProtocol] = [],
         navigationController: UINavigationController) {
        self.childCoordinators = childCoordinators
        self.navigationController = navigationController
    }

    func start() {
        let riderBookApiService = RiderBookApiService()
        let userRepository = UserRepository(riderBookApiService: riderBookApiService)
        let localRepository = LocalRepository()
        let loginService = LoginService(userRepository: userRepository, localRepository: localRepository)
        let loginViewModel = LoginViewModel(loginService: loginService, coordinator: self)
        let loginView = LoginView(viewModel: loginViewModel)
        let hostingController = UIHostingController(rootView: loginView)
        navigationController.pushViewController(hostingController, animated: false)
    }
}
