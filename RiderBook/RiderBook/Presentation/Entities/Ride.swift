//
//  Ride.swift
//  RiderBook
//
//  Created by Pere Almendro on 27/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

class Ride {
    let date: Date
    let circuit: String

    init(date: Date,
         circuit: String) {
        self.date = date
        self.circuit = circuit
    }
}
