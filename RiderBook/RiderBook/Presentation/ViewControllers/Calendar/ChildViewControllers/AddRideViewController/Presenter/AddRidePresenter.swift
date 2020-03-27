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
    private let circuitNames: [String] = ["Alcarras", "Castelloli", "Montmelo", "Calafat"]
    
    // MARK: - Lifecycle
    
    init(addRideRouter: AddRideRouter) {
        self.addRideRouter = addRideRouter
    }
    
    // MARK: - Public functions
    
    func getCircuitNames() -> [String] {
        return circuitNames
    }
    
    // MARK: - User Actions
    
    func saveAction() {
        addRideRouter.dismiss()
    }
    
}
