//
//  AddRideRouter.swift
//  RiderBook
//
//  Created by Pere Almendro on 26/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

protocol AddRideRouter { }

class AddRideRouterImpl: AddRideRouter {
    private let baseRouter: BaseRouter
    
    init(baseRouter: BaseRouter) {
        self.baseRouter = baseRouter
    }
}

