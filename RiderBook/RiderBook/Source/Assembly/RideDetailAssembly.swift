//
//  RideDetailAssembly.swift
//  RiderBook
//
//  Created by Pere Almendro on 03/05/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import UIKit

class RideDetailAssembly {
    private let coordinator: AppCoordinatorProtocol
    
    init(coordinator: AppCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func getView(for ride: Ride) -> RideDetailView {
        let riderBookApiService = RiderBookApiService()
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let localRepository = LocalRepository(context: context)
        let lapRepository = LapRepository(riderBookApiService: riderBookApiService, localRepository: localRepository)
        let lapService = LapService(lapRepository: lapRepository)
        let rideDetailViewModel = RideDetailViewModel(lapService: lapService, coordinator: coordinator, ride: ride)
        return RideDetailView(viewModel: rideDetailViewModel)
    }
}
