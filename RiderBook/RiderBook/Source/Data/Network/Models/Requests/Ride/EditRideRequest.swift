//
//  EditRideRequest.swift
//  RiderBook
//
//  Created by Pere Almendro on 15/05/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

struct EditRideRequest: Encodable, RequestableProtocol {
    let rideId: Int
    let circuitId: Int
    let dateTimeStamp: Int
    let authorization: String
    
    func toJsonData() -> Data? {
        return ["rideId" : rideId,
                "circuitId" : circuitId,
                "date" : dateTimeStamp].toJsonData()
    }
}
