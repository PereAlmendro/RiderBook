//
//  RideListRequest.swift
//  RiderBook
//
//  Created by Pere Almendro on 19/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

struct RideListRequest: Encodable, RequestableProtocol {
    let page: Int
    let authorization: String
    
    func toJsonData() -> Data? {
        return ["page": page].toJsonData()
    }
}
