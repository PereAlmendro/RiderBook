//
//  AddEditRideCoordinator.swift
//  RiderBook
//
//  Created by Pere Almendro on 18/12/20.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

final class AddEditRideCoordinator: CoordinatorProtocol {
    var childCoordinators: [CoordinatorProtocol]
    var navigationController: UINavigationController

    init(childCoordinators: [CoordinatorProtocol] = [],
         navigationController: UINavigationController) {
        self.childCoordinators = childCoordinators
        self.navigationController = navigationController
    }

    func start() {
        start(withMode: .add)
    }

    func start(withMode mode: AddEditRideViewModel.ScreenMode, ride: Ride? = nil) {
        let apiService = RiderBookApiService()
        let localRepository = LocalRepository()
        let rideRepository = RideRepository(riderBookApiService: apiService)
        let rideService = RideService(rideRepository: rideRepository, localRepository: localRepository)
        let circuitRepositry = CircuitRepository(riderBookApiService: apiService)
        let circuitService = CircuitService(circuitRepository: circuitRepositry)
        let viewModel = AddEditRideViewModel(rideService: rideService,
                                             circuitService: circuitService,
                                             coordinator: self,
                                             screenMode: mode,
                                             ride: ride)
        let view = AddEditRideView(viewModel: viewModel)
        let hostingController = UIHostingController(rootView: view)
        navigationController.present(hostingController, animated: true)
    }
}
