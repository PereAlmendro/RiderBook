//
//  TabBarCoordinator.swift
//  RiderBook
//
//  Created by Pere Almendro on 18/12/20.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

final class TabBarCoordinator: CoordinatorProtocol {
    var childCoordinators: [CoordinatorProtocol]
    var navigationController: UINavigationController

    private var tabView: TabBarView?

    init(childCoordinators: [CoordinatorProtocol] = [],
         navigationController: UINavigationController) {
        self.childCoordinators = childCoordinators
        self.navigationController = navigationController
    }

    func start() {
        let tabView = getTabBarView()
        let hostingController = UIHostingController(rootView: tabView)
        hostingController.modalPresentationStyle = .fullScreen
        navigationController.present(hostingController, animated: true)
    }

    func showAddRide() {
        let child = AddEditRideCoordinator(navigationController: navigationController)
        childCoordinators.append(child)
        child.start(withMode: .add)
    }

    func showEditRide(for ride: Ride) {
        let child = AddEditRideCoordinator(navigationController: navigationController)
        childCoordinators.append(child)
        child.start(withMode: .edit, ride: ride)
    }

    func showRideDetail(for ride: Ride) {
        
    }

}

private extension TabBarCoordinator {
    func getTabBarView() -> TabBarView? {
        if let tabView = tabView {
            return tabView
        }

        let homeView = getHomeView()
        let ridesView = getRidesView()
        let profileView = getProfileView()

        return TabBarView(homeView: homeView,
                          ridesView: ridesView,
                          profileView: profileView)
    }

    func getHomeView() -> HomeView {
        let homeViewModel = HomeViewModel(coordinator: self)
        return HomeView(viewModel: homeViewModel)
    }

    func getRidesView() -> RidesView {
        let riderBookApiService = RiderBookApiService()
        let rideRepository = RideRepository(riderBookApiService: riderBookApiService)
        let localRepository = LocalRepository()
        let rideService = RideService(rideRepository: rideRepository, localRepository: localRepository)
        let rideViewModel = RidesViewModel(rideService: rideService, coordinator: self)
        return RidesView(viewModel: rideViewModel)

    }

    func getProfileView() -> ProfileView {
        let riderBookApiService = RiderBookApiService()
        let userRepository = UserRepository(riderBookApiService: riderBookApiService)
        let localRepository = LocalRepository()
        let loginService = LoginService(userRepository: userRepository, localRepository: localRepository)
        let userService = UserService(userRepository: userRepository, localRepository: localRepository)
        let profileViewModel = ProfileViewModel(loginService: loginService,
                                                userService: userService,
                                                coordinator: self)
        return ProfileView(viewModel: profileViewModel)
    }
}
