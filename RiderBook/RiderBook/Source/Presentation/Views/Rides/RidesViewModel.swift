//
//  RidesViewModel.swift
//  RiderBook
//
//  Created by Pere Almendro on 19/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

class RidesViewModel: ObservableObject  {

    // MARK: - View properties
    
    // MARK: - Private properties
    
    private let coordinator: AppCoordinatorProtocol

    // MARK: - Lifecycle
    
    init(coordinator: AppCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    // MARK: - User Actions
    
    func addRideAction() {
        coordinator.showAddRide()
    }
    
    // MARK: - Private methods
}
