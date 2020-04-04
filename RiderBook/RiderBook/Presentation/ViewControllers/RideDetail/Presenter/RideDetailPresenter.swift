//
//  RideDetailPresenter.swift
//  RiderBook
//
//  Created by Pere Almendro on 03/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

class RideDetailPresenter: BasePresenter {
    
    // MARK: - Properties
    
    private let rideDetailRouter: RideDetailRouter
    private let rideDetailInteractor: RideDetailInteractor
    
    // MARK: - Outcomming params
    
    var ride: Ride?
    
    // MARK: - Lyfecycle
    
    init(rideDetailRouter: RideDetailRouter, rideDetailInteractor: RideDetailInteractor) {
        self.rideDetailRouter = rideDetailRouter
        self.rideDetailInteractor = rideDetailInteractor
    }
}
