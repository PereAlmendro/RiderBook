//
//  AddLapRequest.swift
//  RiderBook
//
//  Created by Pere Almendro on 03/05/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

struct AddLapRequest: Encodable, RequestableProtocol {
    let rideId: Int
    let lapTimeInSeconds: String
    let number: Int
    let authorization: String
    
    func toJsonData() -> Data? {
        return ["rideId": rideId,
                "lapTimeInSeconds" : lapTimeInSeconds,
                "number" : number].toJsonData()
    }
}
