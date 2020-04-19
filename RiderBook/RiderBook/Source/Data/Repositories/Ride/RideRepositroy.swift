//
//  RideRepositroy.swift
//  RiderBook
//
//  Created by Pere Almendro on 19/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import RxSwift

protocol RideRepositoryProtocol {
    func addRide(circuitId: Int, date: Date) -> Single<Bool>
}

class RideRepository: RideRepositoryProtocol {
    
    private let riderBookApiService: RiderBookApiServiceProtocol
    
    init(riderBookApiService: RiderBookApiServiceProtocol) {
        self.riderBookApiService = riderBookApiService
    }
    
    func addRide(circuitId: Int, date: Date) -> Single<Bool> {
        let addRideRequest = AddRideRequest(circuitId: circuitId, dateTimeStamp: Int(date.timeIntervalSince1970), authorization: "")
        
        return riderBookApiService
            .loadRequest(RideTarget.addRide(addRideRequest), responseModel: AddRideResponse.self)
            .flatMap({ (result) -> Single<Bool> in
                guard let result = try? result.get(),
                    result.id != nil else {
                    return Single.just(false)
                }
                return Single.just(true)
        }).asSingle()
    }
    
}
