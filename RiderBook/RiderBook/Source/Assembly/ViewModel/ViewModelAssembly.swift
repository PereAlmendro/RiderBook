//
//  ViewModelAssembly.swift
//  RiderBook
//
//  Created by Pere Almendro on 17/05/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

protocol ViewModelAssemblyProtocol {
    func getLoginViewModel() -> LoginViewModelProtocol
    func getSplashViewModel() -> SplashViewModelProtocol
    func getHomeViewModel() -> HomeViewModelProtocol
    func getRidesViewModel() -> RidesViewModelProtocol
    func getProfileViewModel() -> ProfileViewModelProtocol
    func getRegisterViewModel() -> RegisterViewModelProtocol
    func getAddEditRideViewModel(mode: AddEditRideViewModel.ScreenMode,
                                 ride: Ride?) -> AddEditRideViewModelProtocol
    func getRideDetailViewModel(for ride: Ride) -> RideDetailViewModelProtocol
}

final class ViewModelAssembly: ViewModelAssemblyProtocol {
    
    // MARK: - Private properties
    
    private weak var coordinator: AppCoordinatorProtocol!
    private let serviceAssembly: ServiceAssemblyProtocol
    
    // MARK: - Lifecycle
    
    init(coordinator: AppCoordinatorProtocol,
         serviceAssembly: ServiceAssemblyProtocol) {
        self.coordinator = coordinator
        self.serviceAssembly = serviceAssembly
    }
    
    // MARK: - ViewModelAssemblyProtocol
    
    func getSplashViewModel() -> SplashViewModelProtocol {
        let loginService = serviceAssembly.getLoginService()
        return SplashViewModel(loginService: loginService,
                               coordinator: coordinator)
    }
    
    func getLoginViewModel() -> LoginViewModelProtocol {
        let loginService = serviceAssembly.getLoginService()
        return LoginViewModel(loginService: loginService,
                              coordinator: coordinator)
    }
    
    func getHomeViewModel() -> HomeViewModelProtocol {
        return HomeViewModel(coordinator: coordinator)
    }
    
    func getRidesViewModel() -> RidesViewModelProtocol {
        let rideService = serviceAssembly.getRideService()
        return RidesViewModel(rideService: rideService,
                              coordinator: coordinator)
    }
    
    func getProfileViewModel() -> ProfileViewModelProtocol {
        let loginService = serviceAssembly.getLoginService()
        let userService = serviceAssembly.getUserService()
        return ProfileViewModel(loginService: loginService,
                                userService: userService,
                                coordinator: coordinator)
    }
    
    func getRegisterViewModel() -> RegisterViewModelProtocol {
        let loginService = serviceAssembly.getLoginService()
        return RegisterViewModel(loginService: loginService, coordinator: coordinator)
    }
    
    func getAddEditRideViewModel(mode: AddEditRideViewModel.ScreenMode = .add, ride: Ride? = nil) -> AddEditRideViewModelProtocol {
        let rideService = serviceAssembly.getRideService()
        let circuitService = serviceAssembly.getCircuitService()
        return AddEditRideViewModel(rideService: rideService,
                                    circuitService: circuitService,
                                    coordinator: coordinator,
                                    screenMode: mode,
                                    ride: ride)
    }
    
    func getRideDetailViewModel(for ride: Ride) -> RideDetailViewModelProtocol {
        let lapService = serviceAssembly.getLapService()
        return RideDetailViewModel(lapService: lapService,
                                   coordinator: coordinator,
                                   ride: ride)
    }
}
