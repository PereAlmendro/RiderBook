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
    case uploadImage(_ request: UploadImageRequest)
}

extension UserTarget {
    var endPoint: String {
        switch self {
        case .createUser:
            return UserEndpoint.new.rawValue
        case .login:
            return UserEndpoint.login.rawValue
        case .uploadImage:
            return UserEndpoint.uploadImage.rawValue
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .createUser, .login, .uploadImage:
            return .post
        }
    }
    
    var requestObject: RequestableProtocol? {
        switch self {
        case .createUser(let request):
            return request
        case .login(let request):
            return request
        case .uploadImage(let request):
            return request
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .uploadImage(let request):
            return ["Content-Type": "application/json", "authorization" : request.authorization]
        default:
            return ["Content-Type": "application/json"]
        }
    }
}
