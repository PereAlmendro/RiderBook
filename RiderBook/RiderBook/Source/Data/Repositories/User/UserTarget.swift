//
//  UserTarget.swift
//  RiderBook
//
//  Created by Pere Almendro on 12/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

enum UserTarget: ApiTargetProtocol {
    case createUser(_ request: CreateUserRequest)
    case login(_ request: LoginRequest)
    case uploadImage(_ request: UploadImageRequest)
    case deleteUser(_ request: DeleteUserRequest)
}

extension UserTarget {

    var baseUrl: String {
        return EnvironmentController.shared.urls.baseUrl
    }
    
    var endPoint: String {
        switch self {
        case .createUser:
            return "/user/new"
        case .login:
            return "/user/login"
        case .uploadImage:
            return "/user/upload-image"
        case .deleteUser:
            return "/user/delete"
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .createUser, .login, .uploadImage:
            return .post
        case .deleteUser:
            return .delete
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
        case .deleteUser(let request):
            return request
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .uploadImage(let request):
            return ["Content-Type": "application/json", "authorization" : request.authorization]
        case .deleteUser(let request):
            return ["Content-Type": "application/json", "authorization" : request.authorization]
        default:
            return ["Content-Type": "application/json"]
        }
    }
}
