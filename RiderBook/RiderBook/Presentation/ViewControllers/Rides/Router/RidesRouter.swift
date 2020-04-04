//
//  RidesRouter.swift
//  RiderBook
//
//  Created by Pere Almendro on 29/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

protocol RidesRouter: BaseRouter {
    func showRide(ride: Ride)
}

class RidesRouterImpl: RidesRouter {
    
    // MARK: - Properties
    
    var coordinator: AppCoordinator?
    
    // MARK: - Lifecycle
    
    required init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    func showRide(ride: Ride) {
        coordinator?.showDetail(of: ride)
    }
}
