//
//  AddRideRouter.swift
//  RiderBook
//
//  Created by Pere Almendro on 26/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

protocol AddRideRouter {
    func dismiss()
}

class AddRideRouterImpl: AddRideRouter {
    
    // MARK: - Properties
    
    private let baseRouter: BaseRouter
    
    // MARK: - Lifecycle
    
    init(baseRouter: BaseRouter) {
        self.baseRouter = baseRouter
    }
    
    func dismiss() {
        baseRouter.dismiss(animated: true, completion: nil)
    }
}

