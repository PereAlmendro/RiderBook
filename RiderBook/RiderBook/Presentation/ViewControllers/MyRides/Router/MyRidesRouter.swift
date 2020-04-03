//
//  MyRidesRouter.swift
//  RiderBook
//
//  Created by Pere Almendro on 29/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

protocol MyRidesRouter { }

class MyRidesRouterImpl: MyRidesRouter {
    
    // MARK: - Properties
    
    private let baseRouter: BaseRouter
    
    // MARK: - Lifecycle
    
    init(baseRouter: BaseRouter) {
        self.baseRouter = baseRouter
    }
}
