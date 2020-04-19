//
//  AddRideViewModel.swift
//  RiderBook
//
//  Created by Pere Almendro on 19/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

class AddRideViewModel: ObservableObject  {

    // MARK: - View properties
    
    // MARK: - Private properties
    
    private let rideService: RideServiceProtocol
    private var coordinator: AppCoordinatorProtocol
    
    // MARK: - Lifecycle
    
    init(rideService: RideServiceProtocol, coordinator: AppCoordinatorProtocol) {
        self.rideService = rideService
        self.coordinator = coordinator
    }
    
    // MARK: - User Actions
    
    func addRideAction() {
        
    }
    
    // MARK: - Private methods
}
