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
    func fetchRides(page: Int) -> AnyPublisher<[Ride], RiderBookError>
    func deleteRide(ride: Ride) -> AnyPublisher<Bool, RiderBookError>
}

final class RideService: RideServiceProtocol {
    
    // MARK: - Private properties
    
    private let rideRepository: RideRepositoryProtocol
    
    // MARK: - Lifecycle
    
    init(rideRepository: RideRepositoryProtocol) {
        self.rideRepository = rideRepository
    }
    
    // MARK: - RideServiceProtocol
    
    func addRide(ride: Ride) -> AnyPublisher<Bool, RiderBookError> {
        return rideRepository.addRide(circuitId: ride.circuitId, date: ride.date)
    }
    
    func fetchRides(page: Int) -> AnyPublisher<[Ride], RiderBookError> {
        return rideRepository.fetchRides(page: page)
    }
    
    func deleteRide(ride: Ride) -> AnyPublisher<Bool, RiderBookError> {
        return rideRepository.deleteRide(rideId: ride.id)
    }
    
    // TODO: Edit ride
}
