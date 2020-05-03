//
//  LapListRequest.swift
//  RiderBook
//
//  Created by Pere Almendro on 03/05/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

struct LapListRequest: Encodable, RequestableProtocol {
    let page: Int
    let rideId: Int
    let authorization: String
    
    func toJsonData() -> Data? {
        return ["page": page,
                "rideId": page].toJsonData()
    }
}
