//
//  AddRideResponse.swift
//  RiderBook
//
//  Created by Pere Almendro on 19/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

struct AddRideResponse: Codable {
    let id: String?
    let date: Int?
    let circuitId: Int?
    let userId: Int?
}
