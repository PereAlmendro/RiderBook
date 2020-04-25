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
}

class RideRepository: RideRepositoryProtocol {
    
    private let riderBookApiService: RiderBookApiServiceProtocol
    private let localRepository: LocalRepositoryProtocol
    
    init(riderBookApiService: RiderBookApiServiceProtocol,
         localRepository: LocalRepositoryProtocol) {
        self.riderBookApiService = riderBookApiService
        self.localRepository = localRepository
    }
    
    func addRide(circuitId: Int, date: Date) -> AnyPublisher<Bool, RiderBookError> {
        let userAuth = localRepository.getUser()?.authorization
        let addRideRequest = AddRideRequest(circuitId: circuitId,
                                            dateTimeStamp: Int(date.timeIntervalSince1970),
                                            authorization: userAuth ?? "")
        return riderBookApiService
            .loadRequest(RideTarget.addRide(addRideRequest), responseModel: AddRideResponse.self)
            .map { (response) -> Bool in
                return response?.success ?? false
        }.eraseToAnyPublisher()
    }
    
}
