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
    
    private let baseRouter: BaseRouter
    
    init(baseRouter: BaseRouter) {
        self.baseRouter = baseRouter
    }
    
    func showAddRide() {
        guard let addRideVC = SwinjectStoryboard.defaultContainer.resolve(AddRideViewController.self) else {
            assertionFailure("Unable to resolve AddRideViewController")
            return
        }
        baseRouter.present(vc: addRideVC, animated: true, completion: nil)
    }
}
