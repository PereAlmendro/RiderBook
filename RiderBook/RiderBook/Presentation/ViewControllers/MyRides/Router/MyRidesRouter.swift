//
//  MyRidesRouter.swift
//  RiderBook
//
//  Created by Pere Almendro on 29/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

protocol MyRidesRouter: BaseRouter {
    func showRide(ride: Ride)
}

class MyRidesRouterImpl: MyRidesRouter {
    
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
