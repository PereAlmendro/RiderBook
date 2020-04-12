//
//  CreateUserRequest.swift
//  RiderBook
//
//  Created by Pere Almendro on 12/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

struct LoginRequest: Encodable, Requestable {
    let email: String
    let password: String
    
    func toJsonData() -> Data? {
        return try? JSONSerialization.data(withJSONObject: ["email" : email,
                                                            "password" : password ],
                                           options: .prettyPrinted)
    }
}

struct CreateUserRequest: Encodable, Requestable {
    let name: String
    let password: String
    let image: String
    let email: String
    
    func toJsonData() -> Data? {
        return try? JSONSerialization.data(withJSONObject: ["name" : name,
                                                            "password" : password,
                                                            "image" : image,
                                                            "email" : email ],
                                           options: .prettyPrinted)
    }
}

struct UserResponse: Codable {
    let id: Int?
    let email: String?
    let name: String?
    let image: String?
    let expiryDate: Int?
    let auth: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case email = "email"
        case name = "name"
        case image = "image"
        case auth = "auth"
        case expiryDate = "expiry_date"
    }
}

