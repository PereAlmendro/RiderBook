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
    func addRide(circuitId: Int, date: Date, userAuth: String) -> AnyPublisher<Bool, RiderBookError>
    func fetchRides(page: Int, userAuth: String) -> AnyPublisher<[Ride], RiderBookError>
    func deleteRide(rideId: Int, userAuth: String) -> AnyPublisher<Bool, RiderBookError>
    func editRide(rideId: Int, circuitId: Int, date: Date, userAuth: String) -> AnyPublisher<Bool, RiderBookError>
}

final class RideRepository {

    private let riderBookApiService: RiderBookApiServiceProtocol

    init(riderBookApiService: RiderBookApiServiceProtocol) {
        self.riderBookApiService = riderBookApiService
    }
}

extension RideRepository: RideRepositoryProtocol {
    
    func addRide(circuitId: Int, date: Date, userAuth: String) -> AnyPublisher<Bool, RiderBookError> {
        let addRideRequest = AddRideRequest(circuitId: circuitId,
                                            dateTimeStamp: Int(date.timeIntervalSince1970),
                                            authorization: userAuth)
        return riderBookApiService
            .loadRequest(RideTarget.addRide(addRideRequest), responseModel: RiderBookServiceSuccessResponse.self)
            .map { (response) -> Bool in
                return response?.success ?? false
        }.eraseToAnyPublisher()
    }
    
    func fetchRides(page: Int, userAuth: String) -> AnyPublisher<[Ride], RiderBookError> {
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
    
    func deleteRide(rideId: Int, userAuth: String) -> AnyPublisher<Bool, RiderBookError> {
        let deleteRideRequest = DeleteRideRequest(rideId: rideId, authorization: userAuth)
        return riderBookApiService
            .loadRequest(RideTarget.deleteRide(deleteRideRequest), responseModel: RiderBookServiceSuccessResponse.self)
            .map { (response) -> Bool in
                return response?.success ?? false
        }.eraseToAnyPublisher()
    }
    
    func editRide(rideId: Int, circuitId: Int, date: Date, userAuth: String) -> AnyPublisher<Bool, RiderBookError> {
        let editRideRequest = EditRideRequest(rideId: rideId,
                                              circuitId: circuitId,
                                              dateTimeStamp: Int(date.timeIntervalSince1970),
                                              authorization: userAuth)
        return riderBookApiService
            .loadRequest(RideTarget.editRide(editRideRequest), responseModel: RiderBookServiceSuccessResponse.self)
            .map { (response) -> Bool in
                return response?.success ?? false
        }.eraseToAnyPublisher()
    }
    
}
