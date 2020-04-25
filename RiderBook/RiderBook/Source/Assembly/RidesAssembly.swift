//
//  RidesAssembly.swift
//  RiderBook
//
//  Created by Pere Almendro on 11/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import UIKit

class RidesAssembly {
    private let coordinator: AppCoordinatorProtocol
    
    init(coordinator: AppCoordinatorProtocol) {
        self.coordinator = coordinator
    }

    func getView() -> RidesView {
        let riderBookApiService = RiderBookApiService()
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let localRepository = LocalRepository(context: context)
        
        let rideRepository = RideRepository(riderBookApiService: riderBookApiService,
                                            localRepository: localRepository)
        let rideService = RideService(rideRepository: rideRepository)
        let rideViewModel = RidesViewModel(coordinator: coordinator, rideService: rideService)
        return RidesView(viewModel: rideViewModel)
    }
}
