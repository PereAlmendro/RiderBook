//
//  RouterDIModule.swift
//  RiderBook
//
//  Created by Pere Almendro on 23/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import Swinject

class RouterDIModule{
    static func setup(_ container: Container) {
        resolveRouter(container)
    }
    
    static func resolveRouter(_ container: Container) {

        // MARK: - AppCoordinator
        
        container.register(AppCoordinator.self) { _ in
            AppCoordinatorImpl()
        }.inObjectScope(.container)
        
        // MARK: - Login

        container.register(LoginRouter.self) { r in
            LoginRouterImpl(coordinator: r.resolve(AppCoordinator.self)!)
        }
        
        // MARK: - Home

        container.register(HomeRouter.self) { r in
            HomeRouterImpl(coordinator: r.resolve(AppCoordinator.self)!)
        }
        
        // MARK: - Profile
        
        container.register(ProfileRouter.self) { r in
            ProfileRouterImpl(coordinator: r.resolve(AppCoordinator.self)!)
        }
        
        // MARK: - Add Ride
        
        container.register(AddRideRouter.self) { r in
            AddRideRouterImpl(coordinator: r.resolve(AppCoordinator.self)!)
        }
        
        // MARK: - My Rides
        
        container.register(RidesRouter.self) { r in
            RidesRouterImpl(coordinator: r.resolve(AppCoordinator.self)!)
        }
        
        // MARK: - Ride Detail
        
        container.register(RideDetailRouter.self) { r in
            RideDetailRouterImpl(coordinator: r.resolve(AppCoordinator.self)!)
        }
    }
}
