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
        // TODO: return a visual format
        return timeInSeconds
    }
}
