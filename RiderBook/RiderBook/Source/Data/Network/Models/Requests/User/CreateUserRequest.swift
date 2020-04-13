//
//  CreateUserRequest.swift
//  RiderBook
//
//  Created by Pere Almendro on 12/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

struct CreateUserRequest: Encodable, Requestable {
    let name: String
    let password: String
    let image: String
    let email: String
    
    func toJsonData() -> Data? {
        let jsonDict = ["name" : name,
                        "password" : password,
                        "image" : image,
                        "email" : email ]
        return try? JSONSerialization.data(withJSONObject: jsonDict,
                                           options: .prettyPrinted)
    }
}

