//
//  ViewControllerDIModule.swift
//  RiderBook
//
//  Created by Pere Almendro on 23/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import Swinject


class ViewControllerDIModule {
    static func setup(_ container: Container) {
        resolveViewControllers(container)
    }
    
    static func resolveViewControllers(_ container: Container) {
        
        // MARK: - Login
        
        container.register(LoginViewController.self) { r in
            let view = LoginViewController()
            view.presenter = r.resolve(LoginPresenter.self)!
            return view
        }
        
        // MARK: - Home
        
        container.register(HomeViewController.self) { r in
            let view = HomeViewController()
            view.presenter = r.resolve(HomePresenter.self)!
            return view
        }
        
        // MARK: - Profile
        
        container.register(ProfileViewController.self) { r in
            let view = ProfileViewController()
            view.presenter = r.resolve(ProfilePresenter.self)!
            return view
        }
        
        // MARK: - Add Ride
        
        container.register(AddRideViewController.self) { r in
            let view = AddRideViewController()
            view.presenter = r.resolve(AddRidePresenter.self)!
            return view
        }
        
        // MARK: - My Rides
        
        container.register(RidesViewController.self) { r in
            let view = RidesViewController()
            view.presenter = r.resolve(RidesPresenter.self)!
            return view
        }
        
        // MARK: - Ride Detail

        container.register(RideDetailViewController.self) { r in
            let view = RideDetailViewController()
            view.presenter = r.resolve(RideDetailPresenter.self)!
            return view
        }
    }
}
