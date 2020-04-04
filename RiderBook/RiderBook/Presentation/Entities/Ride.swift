//
//  Ride.swift
//  RiderBook
//
//  Created by Pere Almendro on 27/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

struct Ride {
    let date: Date
    let circuit: Circuit
    var bestLap: Lap? {
        return laps.first(where: { $0.isBestLap })
    }
    let laps: [Lap]
}
