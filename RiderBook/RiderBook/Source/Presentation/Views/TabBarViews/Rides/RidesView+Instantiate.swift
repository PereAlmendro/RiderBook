//
//  RidesView+Instantiate.swift
//  RiderBook
//
//  Created by Pere Almendro on 20/12/20.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

extension RidesView {
    static func instantiate() -> RidesView {
        let riderBookApiService = RiderBookApiService()
        let rideRepository = RideRepository(riderBookApiService: riderBookApiService)
        let localRepository = LocalRepository()
        let rideService = RideService(rideRepository: rideRepository, localRepository: localRepository)
        let rideViewModel = RidesViewModel(rideService: rideService)
        return RidesView(viewModel: rideViewModel)
    }
}
