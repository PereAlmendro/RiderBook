//
//  DeleteUserRequest.swift
//  RiderBook
//
//  Created by Pere Almendro on 27/06/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

struct DeleteUserRequest: Encodable, RequestableProtocol {
    let userId: Int
    let authorization: String
    
    func toJsonData() -> Data? {
        return ["userId" : userId].toJsonData()
    }
}
