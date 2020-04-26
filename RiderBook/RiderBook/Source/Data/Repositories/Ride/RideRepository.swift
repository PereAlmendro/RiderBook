//
//  RideRepositroy.swift
//  RiderBook
//
//  Created by Pere Almendro on 19/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import Combine

protocol RideRepositoryProtocol {
    func addRide(circuitId: Int, date: Date) -> AnyPublisher<Bool, RiderBookError>
    func fetchRides(page: Int) -> AnyPublisher<[Ride], RiderBookError>
}

final class RideRepository: RideRepositoryProtocol {
    
    // MARK: - Private properties
    
    private let riderBookApiService: RiderBookApiServiceProtocol
    private let localRepository: LocalRepositoryProtocol
    
    // MARK: - Lifecycle
    
    init(riderBookApiService: RiderBookApiServiceProtocol,
         localRepository: LocalRepositoryProtocol) {
        self.riderBookApiService = riderBookApiService
        self.localRepository = localRepository
    }
    
    // MARK: - RideRepositoryProtocol
    
    func addRide(circuitId: Int, date: Date) -> AnyPublisher<Bool, RiderBookError> {
        let userAuth = localRepository.getUser()?.authorization ?? ""
        let addRideRequest = AddRideRequest(circuitId: circuitId,
                                            dateTimeStamp: Int(date.timeIntervalSince1970),
                                            authorization: userAuth)
        return riderBookApiService
            .loadRequest(RideTarget.addRide(addRideRequest), responseModel: AddRideResponse.self)
            .map { (response) -> Bool in
                return response?.success ?? false
        }.eraseToAnyPublisher()
    }
    
    func fetchRides(page: Int) -> AnyPublisher<[Ride], RiderBookError> {
        let userAuth = localRepository.getUser()?.authorization ?? ""
        let rideListRequest = RideListRequest(page: page, authorization: userAuth)
        return riderBookApiService
            .loadRequest(RideTarget.rideList(rideListRequest), responseModel: RideListResponse.self)
            .map { (response) -> [Ride] in
                guard let rides = response?.rides else {
                    return []
                }
                return rides.compactMap { RideFactory.createRide(from: $0) }
        }.eraseToAnyPublisher()
    }
    
}
