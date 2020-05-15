//
//  EditLapRequest.swift
//  RiderBook
//
//  Created by Pere Almendro on 15/05/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

struct EditLapRequest: Encodable, RequestableProtocol {
    let rideId: Int
    let lapId: Int
    let lapTimeInSeconds: String
    let authorization: String
    
    func toJsonData() -> Data? {
        return ["lapId": lapId,
                "rideId" : rideId,
                "lapTimeInSeconds" : lapTimeInSeconds].toJsonData()
    }
}
