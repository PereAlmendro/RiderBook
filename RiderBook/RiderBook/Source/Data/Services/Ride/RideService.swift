//
//  RideService.swift
//  RiderBook
//
//  Created by Pere Almendro on 19/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import Combine

protocol RideServiceProtocol {
    func addRide(ride: Ride) -> AnyPublisher<Bool, RiderBookError>
}

class RideService: RideServiceProtocol {
    
    private let rideRepository: RideRepositoryProtocol
    
    init(rideRepository: RideRepositoryProtocol) {
        self.rideRepository = rideRepository
    }
    
    func addRide(ride: Ride) -> AnyPublisher<Bool, RiderBookError> {
        return rideRepository.addRide(circuitId: ride.circuitId, date: ride.date)
    }
}
