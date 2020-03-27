//
//  LoginRouter.swift
//  RiderBook
//
//  Created by Pere Almendro on 25/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

protocol LoginRouter {
    func showHomeAsGuest()
    func showHome()
}

class LoginRouterImpl: LoginRouter {
    
    // MARK: - Properties
    
    private let baseRouter: BaseRouter
    
    // MARK: - Lifecycle
    
    init(baseRouter: BaseRouter) {
        self.baseRouter = baseRouter
    }
    
    // MARK: - Navigations
    
    func showHome() {
        baseRouter.openHomeInitializingTabBar()
    }
    
    func showHomeAsGuest() {
        baseRouter.openHomeInitializingTabBar()
    }
}
