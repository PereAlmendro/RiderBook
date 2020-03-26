//
//  PresenterModule.swift
//  RiderBook
//
//  Created by Pere Almendro on 23/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import Swinject

class PresenterModule {
    static func setup(_ container: Container) {
        resolvePresenters(container)
    }
    
    static func resolvePresenters(_ container: Container) {
        
        // MARK: - Login
        
        container.register(LoginPresenter.self) { r in
            LoginPresenter(loginRouter: r.resolve(LoginRouter.self)!)
        }
        
        // MARK: - Home
        
        container.register(HomePresenter.self) { r in
            HomePresenter(homeRouter: r.resolve(HomeRouter.self)!)
        }
        
        // MARK: - Profile
        
        container.register(ProfilePresenter.self) { r in
            ProfilePresenter(profileRouter: r.resolve(ProfileRouter.self)!)
        }
        
        // MARK: - Calendar
        
        container.register(CalendarPresenter.self) { r in
            CalendarPresenter(calendarRouter: r.resolve(CalendarRouter.self)!)
        }
        
        container.register(AddRidePresenter.self) { r in
            AddRidePresenter(addRideRouter: r.resolve(AddRideRouter.self)!)
        }
        
    }}
