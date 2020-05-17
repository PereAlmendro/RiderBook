//
//  ViewAssembly.swift
//  RiderBook
//
//  Created by Pere Almendro on 17/05/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol ViewAssemblyProtocol: AnyObject {
    func getLoginView() -> LoginView
    func getSplashView() -> SplashView
    func getHomeView() -> HomeView
    func getRidesView() -> RidesView
    func getProfileView() -> ProfileView
    func getRegisterView() -> RegisterView
    func getAddEditRideView(mode: AddEditRideViewModel.ScreenMode,
                            ride: Ride?) -> AddEditRideView
    func getRideDetailView(for ride: Ride) -> RideDetailView
}

final class ViewAssembly: ViewAssemblyProtocol {
    
    // MARK: - Private properties
    
    private weak var coordinator: AppCoordinatorProtocol!
    private let serviceAssembly: ServiceAssemblyProtocol
    
    // MARK: - Lifecycle
    
    init(coordinator: AppCoordinatorProtocol,
         serviceAssembly: ServiceAssemblyProtocol) {
        self.coordinator = coordinator
        self.serviceAssembly = serviceAssembly
    }
    
    // MARK: - ViewAssemblyProtocol
    
    func getSplashView() -> SplashView {
        let loginService = serviceAssembly.getLoginService()
        let splashViewModel = SplashViewModel(loginService: loginService,
                                              coordinator: coordinator)
        return SplashView(viewModel: splashViewModel)
    }
    
    func getLoginView() -> LoginView {
        let loginService = serviceAssembly.getLoginService()
        let loginViewModel = LoginViewModel(loginService: loginService,
                                            coordinator: coordinator)
        return LoginView(viewModel: loginViewModel)
    }
    
    func getHomeView() -> HomeView {
        let homeViewModel = HomeViewModel(coordinator: coordinator)
        return HomeView(viewModel: homeViewModel)
    }
    
    func getRidesView() -> RidesView {
        let rideService = serviceAssembly.getRideService()
        let rideViewModel = RidesViewModel(rideService: rideService,
                                           coordinator: coordinator)
        return RidesView(viewModel: rideViewModel)
    }
    
    func getProfileView() -> ProfileView {
        let loginService = serviceAssembly.getLoginService()
        let userService = serviceAssembly.getUserService()
        let profileViewModel = ProfileViewModel(loginService: loginService,
                                                userService: userService,
                                                coordinator: coordinator)
        return ProfileView(viewModel: profileViewModel)
    }
    
    func getRegisterView() -> RegisterView {
        let loginService = serviceAssembly.getLoginService()
        let registerViewModel = RegisterViewModel(loginService: loginService, coordinator: coordinator)
        return RegisterView(viewModel: registerViewModel)
    }
    
    func getAddEditRideView(mode: AddEditRideViewModel.ScreenMode = .add, ride: Ride? = nil) -> AddEditRideView {
        let rideService = serviceAssembly.getRideService()
        let circuitService = serviceAssembly.getCircuitService()
        let addRideViewModel = AddEditRideViewModel(rideService: rideService,
                                                    circuitService: circuitService,
                                                    coordinator: coordinator,
                                                    screenMode: mode,
                                                    ride: ride)
        return AddEditRideView(viewModel: addRideViewModel)
    }
    
    func getRideDetailView(for ride: Ride) -> RideDetailView {
        let lapService = serviceAssembly.getLapService()
        let rideDetailViewModel = RideDetailViewModel(lapService: lapService,
                                                      coordinator: coordinator,
                                                      ride: ride)
        return RideDetailView(viewModel: rideDetailViewModel)
    }
}
