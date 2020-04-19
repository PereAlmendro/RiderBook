//
//  RideListResponse.swift
//  RiderBook
//
//  Created by Pere Almendro on 19/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

struct RideListResponse: Codable {
    let totalItemsCount: Int?
    let actualPage: Int?
    let itemsPerPage: Int?
    let totalPages: Int?
    let rides: [RideResponse]?    
}

struct RideResponse: Codable {
    let rideId: Int
    let rideDate: Int
    let circuitId: Int
    let circuitName: String
    let circuitLocation: String
}
