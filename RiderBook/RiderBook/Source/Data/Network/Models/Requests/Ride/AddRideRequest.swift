//
//  AddRideRequest.swift
//  RiderBook
//
//  Created by Pere Almendro on 19/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

struct AddRideRequest: Encodable, RequestableProtocol {
    let circuitId: Int
    let dateTimeStamp: Int
    let authorization: String
    
    func toJsonData() -> Data? {
        return ["circuitId" : circuitId,
                "date" : dateTimeStamp ].toJsonData()
    }
}
