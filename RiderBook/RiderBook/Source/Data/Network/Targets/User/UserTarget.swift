//
//  UserTarget.swift
//  RiderBook
//
//  Created by Pere Almendro on 12/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

enum UserEndpoint: String  {
    case new = "/user/new"
    case login = "/user/login"
    case uploadImage = "/user/upload-image"
    case edit = "/user/edit"
    case delete = "/user/delete"
}

enum UserTarget: ApiTargetProtocol {
    case createUser(_ request: CreateUserRequest)
    case login(_ request: LoginRequest)
}

extension UserTarget {
    var endPoint: String {
        switch self {
        case .createUser:
            return UserEndpoint.new.rawValue
        case .login:
            return UserEndpoint.login.rawValue
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .createUser, .login:
            return .post
        }
    }
    
    var requestObject: RequestableProtocol? {
        switch self {
        case .createUser(let request):
            return request
        case .login(let request):
            return request
        }
    }
}
