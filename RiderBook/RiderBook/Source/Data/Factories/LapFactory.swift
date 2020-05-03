//
//  LapFactory.swift
//  RiderBook
//
//  Created by Pere Almendro on 03/05/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

protocol LapFactoryProtocol {
    static func createLap(from lapResponse: LapResponse) -> Lap?
}

final class LapFactory: LapFactoryProtocol {
    static func createLap(from lapResponse: LapResponse) -> Lap? {
        return Lap(rideId: lapResponse.rideId,
                   lapId: lapResponse.lapId,
                   number: lapResponse.lapNumber,
                   timeInSeconds: lapResponse.lapTimeInSeconds)
    }
}
