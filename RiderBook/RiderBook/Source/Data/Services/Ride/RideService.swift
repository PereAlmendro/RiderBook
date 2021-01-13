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
    func addRide(ride: Ride) -> AnyPublisher<Bool, APIProviderError>
    func fetchRides(page: Int) -> AnyPublisher<[Ride], APIProviderError>
    func deleteRide(ride: Ride) -> AnyPublisher<Bool, APIProviderError>
    func editRide(ride: Ride) -> AnyPublisher<Bool, APIProviderError>
}

final class RideService {

    private let rideRepository: RideRepositoryProtocol
    private let localRepository: LocalRepositoryProtocol
    private var userAuth: String {
        return localRepository.getUser()?.authorization ?? ""
    }

    init(rideRepository: RideRepositoryProtocol,
         localRepository: LocalRepositoryProtocol) {
        self.rideRepository = rideRepository
        self.localRepository = localRepository
    }
}

extension RideService: RideServiceProtocol {
    func addRide(ride: Ride) -> AnyPublisher<Bool, APIProviderError> {
        return rideRepository.addRide(circuitId: ride.circuitId,
                                      date: ride.date,
                                      userAuth: userAuth)
    }
    
    func fetchRides(page: Int) -> AnyPublisher<[Ride], APIProviderError> {
        return rideRepository.fetchRides(page: page,
                                         userAuth: userAuth)
    }
    
    func deleteRide(ride: Ride) -> AnyPublisher<Bool, APIProviderError> {
        return rideRepository.deleteRide(rideId: ride.id,
                                         userAuth: userAuth)
    }
    
    func editRide(ride: Ride) -> AnyPublisher<Bool, APIProviderError> {
        return rideRepository.editRide(rideId: ride.id,
                                       circuitId: ride.circuitId,
                                       date: ride.date,
                                       userAuth: userAuth)
    }
}
