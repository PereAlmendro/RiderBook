//
//  RideDetailRouter.swift
//  RiderBook
//
//  Created by Pere Almendro on 03/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

protocol RideDetailRouter { }

class RideDetailRouterImpl: RideDetailRouter {
    
    // MARK: - Properties
    
    private let baseRouter: BaseRouter
    
    // MARK: - Lifecycle
    
    init(baseRouter: BaseRouter) {
        self.baseRouter = baseRouter
    }
}
