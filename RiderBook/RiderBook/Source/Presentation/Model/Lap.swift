//
//  Lap.swift
//  RiderBook
//
//  Created by Pere Almendro on 03/05/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

struct Lap: Hashable {
    let rideId: Int
    let lapId: Int
    let number: Int
    let timeInSeconds: String
    
    func getFormattedTime() -> String {
        let time = Double(timeInSeconds) ?? 0.0
        let (hr,  minf) = modf (time / 3600)
        let (min, secf) = modf (60 * minf)
        let (_ ,minutes,seconds) = (hr, min, 60 * secf)
        return "\(Int(minutes)) min \(seconds.string(maximumFractionDigits: 2)) sec"
    }
}
