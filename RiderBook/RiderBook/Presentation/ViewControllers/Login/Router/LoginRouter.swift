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
}

class LoginRouterImpl: LoginRouter {
    
    private let baseRouter: BaseRouter
    
    init(baseRouter: BaseRouter) {
        self.baseRouter = baseRouter
    }
    
    func showHomeAsGuest() {
        baseRouter.openHomeInitializingTabBar()
    }
}
