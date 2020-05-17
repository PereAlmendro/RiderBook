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
    func editRide(ride: Ride) -> AnyPublisher<Bool, RiderBookError>
}

final class RideService: RideServiceProtocol {
    
    // MARK: - Private properties
    
    private let rideRepository: RideRepositoryProtocol
    private let localRepository: LocalRepositoryProtocol
    private var userAuth: String {
        return self.localRepository.getUser()?.authorization ?? ""
    }
    
    // MARK: - Lifecycle
    
    init(rideRepository: RideRepositoryProtocol,
         localRepository: LocalRepositoryProtocol) {
        self.rideRepository = rideRepository
        self.localRepository = localRepository
    }
    
    // MARK: - RideServiceProtocol
    
    func addRide(ride: Ride) -> AnyPublisher<Bool, RiderBookError> {
        return rideRepository.addRide(circuitId: ride.circuitId,
                                      date: ride.date,
                                      userAuth: userAuth)
    }
    
    func fetchRides(page: Int) -> AnyPublisher<[Ride], RiderBookError> {
        return rideRepository.fetchRides(page: page,
                                         userAuth: userAuth)
    }
    
    func deleteRide(ride: Ride) -> AnyPublisher<Bool, RiderBookError> {
        return rideRepository.deleteRide(rideId: ride.id,
                                         userAuth: userAuth)
    }
    
    func editRide(ride: Ride) -> AnyPublisher<Bool, RiderBookError> {
        return rideRepository.editRide(rideId: ride.id,
                                       circuitId: ride.circuitId,
                                       date: ride.date,
                                       userAuth: userAuth)
    }
}
