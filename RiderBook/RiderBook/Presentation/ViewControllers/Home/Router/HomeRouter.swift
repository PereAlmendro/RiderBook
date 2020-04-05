//
//  HomeRouter.swift
//  RiderBook
//
//  Created by Pere Almendro on 25/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

protocol HomeRouter: BaseRouter {
    func showProfile()
    func showLastRideDetail(_ lastRide: Ride)
}

class HomeRouterImpl: HomeRouter {
    
    // MARK: - Properties
    
    var coordinator: AppCoordinator?
    
    // MARK: - Lifecycle
    
    required init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    // MARK: - Navigations
    
    func showLastRideDetail(_ lastRide: Ride) {
        coordinator?.showDetail(of: lastRide)
    }
    
    func showProfile() {
        coordinator?.select(tab: .profile)
    }
}
