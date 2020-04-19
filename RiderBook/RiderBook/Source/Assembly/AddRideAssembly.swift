//
//  AddRideAssembly.swift
//  RiderBook
//
//  Created by Pere Almendro on 19/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import UIKit

class AddRideAssembly {
    private let coordinator: AppCoordinatorProtocol
    
    init(coordinator: AppCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func getView() -> AddRideView {
        let riderBookApiService = RiderBookApiService()
        
        let rideRepository = RideRepository(riderBookApiService: riderBookApiService)
        let circuitRepository = CircuitRepository(riderBookApiService: riderBookApiService)

        let rideService = RideService(rideRepository: rideRepository)
        let circuitService = CircuitService(circuitRepository: circuitRepository)
        
        let addRideViewModel = AddRideViewModel(rideService: rideService,
                                                circuitService: circuitService,
                                                coordinator: coordinator)
        
        return AddRideView(viewModel: addRideViewModel)
    }
}
