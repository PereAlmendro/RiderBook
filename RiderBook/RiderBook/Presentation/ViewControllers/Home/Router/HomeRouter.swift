//
//  HomeRouter.swift
//  RiderBook
//
//  Created by Pere Almendro on 25/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

protocol HomeRouter {
    func showCalendar()
    func showProfile()
}

class HomeRouterImpl: HomeRouter {
    
    // MARK: - Properties
    
    private let baseRouter: BaseRouter
    
    // MARK: - Lifecycle
    
    init(baseRouter: BaseRouter) {
        self.baseRouter = baseRouter
    }
    
    // MARK: - Navigations
    
    func showCalendar() {
        baseRouter.select(tab: .calendar)
    }
    
    func showProfile() {
        baseRouter.select(tab: .profile)
    }
}
