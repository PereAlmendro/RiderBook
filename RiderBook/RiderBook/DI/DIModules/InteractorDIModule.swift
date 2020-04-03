//
//  InteractorDIModule.swift
//  RiderBook
//
//  Created by Pere Almendro on 27/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import Swinject

class InteractorDIModule {
    static func setup(_ container: Container) {
        resolveInteractors(container)
    }
    
    static func resolveInteractors(_ container: Container) {
        
        // MARK: - Login
        
        container.register(LoginInteractor.self) { _ in
            LoginInteractorImpl()
        }
        
        // MARK: - Home
        
        container.register(HomeInteractor.self) { _ in
            HomeInteractorImpl()
        }
        
        // MARK: - Profile
        
        container.register(ProfileInteractor.self) { _ in
            ProfileInteractorImpl()
        }
        
        // MARK: - Calendar
        
        container.register(CalendarInteractor.self) { _ in
            CalendarInteractorImpl()
        }
        
        // MARK: - Add Ride
        
        container.register(AddRideInteractor.self) { _ in
            AddRideInteractorImpl()
        }
        
        // MARK: - My Rides

        container.register(MyRidesInteractor.self) { _ in
            MyRidesInteractorImpl()
        }
        
        // MARK: - Ride Detail

        container.register(RideDetailInteractor.self) { _ in
            RideDetailInteractorImpl()
        }
    }
}
