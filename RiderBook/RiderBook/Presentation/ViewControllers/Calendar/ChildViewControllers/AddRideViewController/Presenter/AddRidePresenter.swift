//
//  AddRidePresenter.swift
//  RiderBook
//
//  Created by Pere Almendro on 26/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation


class AddRidePresenter: BasePresenter {
    
    // MARK: - Properties
    
    private let addRideRouter: AddRideRouter
    
    // MARK: - Lifecycle
    
    init(addRideRouter: AddRideRouter) {
        self.addRideRouter = addRideRouter
    }
    
}
