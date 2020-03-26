//
//  CalendarRouter.swift
//  RiderBook
//
//  Created by Pere Almendro on 25/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import SwinjectStoryboard

protocol CalendarRouter {
    func showAddRide()
}

class CalendarRouterImpl: CalendarRouter {
    
    // MARK: - Properties
    
    private let baseRouter: BaseRouter
    
    // MARK: - Lifecycle
    
    init(baseRouter: BaseRouter) {
        self.baseRouter = baseRouter
    }
    
    // MARK: - Navigations
    
    func showAddRide() {
        guard let addRideVC = SwinjectStoryboard.defaultContainer.resolve(AddRideViewController.self) else {
            assertionFailure("Unable to resolve AddRideViewController")
            return
        }
        baseRouter.present(vc: addRideVC, animated: true, completion: nil)
    }
}
