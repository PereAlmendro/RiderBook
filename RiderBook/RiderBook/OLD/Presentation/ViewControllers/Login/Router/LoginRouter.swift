//
//  LoginRouter.swift
//  RiderBook
//
//  Created by Pere Almendro on 25/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

protocol LoginRouter: BaseRouter {
    func showHomeAsGuest()
    func showHome()
}

class LoginRouterImpl: LoginRouter {
    
    // MARK: - Properties
    
    var coordinator: AppCoordinator?
    
    // MARK: - Lifecycle
    
    required init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    // MARK: - Navigations
    
    func showHome() {
        coordinator?.openHomeInitializingTabBar()
    }
    
    func showHomeAsGuest() {
        coordinator?.openHomeInitializingTabBar()
    }
}
