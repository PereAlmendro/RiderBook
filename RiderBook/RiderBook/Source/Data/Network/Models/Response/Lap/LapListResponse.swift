//
//  LapListResponse.swift
//  RiderBook
//
//  Created by Pere Almendro on 03/05/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

struct LapListResponse: Codable {
    let totalItemsCount: Int?
    let actualPage: Int?
    let itemsPerPage: Int?
    let totalPages: Int?
    let laps: [LapResponse]?
}

struct LapResponse: Codable {
    let lapId: Int
    let rideId: Int
    let lapNumber: Int
    let lapTimeInSeconds: String
}
