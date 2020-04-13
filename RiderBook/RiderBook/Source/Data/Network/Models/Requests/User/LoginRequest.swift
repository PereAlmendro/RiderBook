//
//  LoginRequest.swift
//  RiderBook
//
//  Created by Pere Almendro on 13/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

struct LoginRequest: Encodable, Requestable {
    let email: String
    let password: String
    
    func toJsonData() -> Data? {
        let jsonDict = ["email" : email,
                        "password" : password ]
        return try? JSONSerialization.data(withJSONObject: jsonDict,
                                           options: .prettyPrinted)
    }
}
