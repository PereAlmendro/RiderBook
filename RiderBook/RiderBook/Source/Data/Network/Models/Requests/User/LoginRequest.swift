//
//  LoginRequest.swift
//  RiderBook
//
//  Created by Pere Almendro on 13/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

struct LoginRequest: Encodable, RequestableProtocol {
    let email: String
    let password: String
    let encodedPassword: Bool
    
    func toJsonData() -> Data? {
        return ["email" : email,
                "password" : password,
                "encodedPassword" : encodedPassword ].toJsonData()
    }
}
