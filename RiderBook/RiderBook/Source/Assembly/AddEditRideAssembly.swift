//
//  AddEditRideAssembly.swift
//  RiderBook
//
//  Created by Pere Almendro on 19/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import UIKit

class AddEditRideAssembly {
    private let coordinator: AppCoordinatorProtocol
    
    init(coordinator: AppCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func getView(mode: AddEditRideViewModel.ScreenMode = .add, ride: Ride? = nil) -> AddEditRideView {
        let riderBookApiService = RiderBookApiService()
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let localRepository = LocalRepository(context: context)
        
        let rideRepository = RideRepository(riderBookApiService: riderBookApiService,
                                            localRepository: localRepository)
        let circuitRepository = CircuitRepository(riderBookApiService: riderBookApiService)

        let rideService = RideService(rideRepository: rideRepository)
        let circuitService = CircuitService(circuitRepository: circuitRepository)
        
        let addRideViewModel = AddEditRideViewModel(rideService: rideService,
                                                circuitService: circuitService,
                                                coordinator: coordinator,
                                                screenMode: mode,
                                                ride: ride)
        
        return AddEditRideView(viewModel: addRideViewModel)
    }
}
