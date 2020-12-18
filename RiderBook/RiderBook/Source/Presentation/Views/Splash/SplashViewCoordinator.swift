//
//  SplashViewCoordinator.swift
//  RiderBook
//
//  Created by Pere Almendro on 18/12/20.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

final class SplashViewCoordinator: CoordinatorProtocol {
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
        let viewModel = SplashViewModel(loginService: loginService, coordinator: self)
        let view = SplashView(viewModel: viewModel)
        let hostingController = UIHostingController(rootView: view)
        navigationController.pushViewController(hostingController, animated: false)
    }

    func showHome() {
        let tabBarCoordinator = TabBarCoordinator(navigationController: navigationController)
        childCoordinators.append(tabBarCoordinator)
        tabBarCoordinator.start()
    }

    func showLogin() {
        let loginCoordinator = LoginViewCoordinator(navigationController: navigationController)
        childCoordinators.append(loginCoordinator)
        loginCoordinator.start()
    }
}
