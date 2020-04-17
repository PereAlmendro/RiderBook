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
    let password: String
    let image: String?
    let expiryDate: Int?

    enum CodingKeys: String, CodingKey {
        case id, email, name, image, auth, password
        case expiryDate = "expiry_date"
    }
}
