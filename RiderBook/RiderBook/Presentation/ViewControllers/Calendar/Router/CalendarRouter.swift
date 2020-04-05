//
//  CalendarRouter.swift
//  RiderBook
//
//  Created by Pere Almendro on 25/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import SwinjectStoryboard

protocol CalendarRouter: BaseRouter {
    func showAddRide()
    func showRide(ride: Ride)
}

class CalendarRouterImpl: CalendarRouter {
    
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
