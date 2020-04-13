//
//  UserResponse.swift
//  RiderBook
//
//  Created by Pere Almendro on 13/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

struct UserResponse: Codable {
    let id: Int
    let email: String
    let auth: String
    let name: String
    let image: String?
    let expiryDate: Int?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case email = "email"
        case name = "name"
        case image = "image"
        case auth = "auth"
        case expiryDate = "expiry_date"
    }
}
