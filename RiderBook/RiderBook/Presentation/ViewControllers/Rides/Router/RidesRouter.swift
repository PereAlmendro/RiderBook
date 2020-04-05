//
//  RidesRouter.swift
//  RiderBook
//
//  Created by Pere Almendro on 25/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import SwinjectStoryboard

protocol RidesRouter: BaseRouter {
    func showAddRide()
    func showRide(ride: Ride)
}

class RidesRouterImpl: RidesRouter {
    
    // MARK: - Properties
    
    var coordinator: AppCoordinator?
    
    // MARK: - Lifecycle
    
    required init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    // MARK: - Navigations
    
    func showAddRide() {
        coordinator?.showAddRide()
    }
    
    func showRide(ride: Ride) {
        coordinator?.showDetail(of: ride)
    }
}
