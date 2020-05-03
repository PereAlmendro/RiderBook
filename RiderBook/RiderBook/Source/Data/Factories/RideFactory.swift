//
//  RideFactory.swift
//  RiderBook
//
//  Created by Pere Almendro on 25/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

protocol RideFactoryProtocol {
    static func createRide(from rideResponse: RideResponse) -> Ride?
}

final class RideFactory: RideFactoryProtocol {
    static func createRide(from rideResponse: RideResponse) -> Ride? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd hh:mm:ss"
        let date = dateFormatter.date(from: rideResponse.rideDate) ?? Date()
        return Ride(id: rideResponse.rideId,
                    date: date,
                    circuit: rideResponse.circuitName,
                    circuitId: rideResponse.circuitId,
                    circuitLocation: rideResponse.circuitLocation)
    }
}
