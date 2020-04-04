//
//  PresenterDIModule.swift
//  RiderBook
//
//  Created by Pere Almendro on 23/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import Swinject

class PresenterDIModule {
    static func setup(_ container: Container) {
        resolvePresenters(container)
    }
    
    static func resolvePresenters(_ container: Container) {
        
        // MARK: - Login
        
        container.register(LoginPresenter.self) { r in
            LoginPresenter(loginRouter: r.resolve(LoginRouter.self)!,
                           loginInteractor: r.resolve(LoginInteractor.self)!)
        }
        
        // MARK: - Home
        
        container.register(HomePresenter.self) { r in
            HomePresenter(homeRouter: r.resolve(HomeRouter.self)!,
                          homeInteractor: r.resolve(HomeInteractor.self)!)
        }
        
        // MARK: - Profile
        
        container.register(ProfilePresenter.self) { r in
            ProfilePresenter(profileRouter: r.resolve(ProfileRouter.self)!,
                             profileInteractor: r.resolve(ProfileInteractor.self)!)
        }
        
        // MARK: - Calendar
        
        container.register(CalendarPresenter.self) { r in
            CalendarPresenter(calendarRouter: r.resolve(CalendarRouter.self)!,
                              calendarInteractor: r.resolve(CalendarInteractor.self)!)
        }
        
        // MARK: - Add Ride
        
        container.register(AddRidePresenter.self) { r in
            AddRidePresenter(addRideRouter: r.resolve(AddRideRouter.self)!,
                             addRideInteractor: r.resolve(AddRideInteractor.self)!)
        }
        
        // MARK: - My Rides
        
        container.register(RidesPresenter.self) { r in
            RidesPresenter(myRidesRouter: r.resolve(RidesRouter.self)!,
                             myRidesInteractor: r.resolve(RidesInteractor.self)!)
        }
        
        // MARK: - Ride Detail
        
        container.register(RideDetailPresenter.self) { r in
            RideDetailPresenter(rideDetailRouter: r.resolve(RideDetailRouter.self)!,
                                rideDetailInteractor: r.resolve(RideDetailInteractor.self)!)
        }
        
    }}
