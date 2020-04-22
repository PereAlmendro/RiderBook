//
//  ApiServiceTestMocks.swift
//  RiderBookTests
//
//  Created by Pere Almendro on 14/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
@testable import RiderBook

enum MockEndpoints: String {
    case invalid = "hello/fake"
    case valid = "/RiderBook/symfony/web/user/login"
}

enum MockTarget: ApiTargetProtocol {
    case invalidUrl
    case invalidPath
    case success
    case error
}

extension MockTarget {
    
    var baseUrl: ApiHostUrl {
        switch self {
        case .invalidPath:
            return .riderBook
        case .invalidUrl:
            return .noHost
        case .error:
            return .invalidHost
        default:
            return .riderBook
        }
    }
    
    var endPoint: String {
        switch self {
        case .success, .error:
            return MockEndpoints.valid.rawValue
        case .invalidPath, .invalidUrl:
            return MockEndpoints.invalid.rawValue
        }
    }
    
    var method: HttpMethod {
        return .post
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    var requestObject: RequestableProtocol? {
        switch self {
        case .success:
            return LoginRequest(email: "test@test.com", password: "test", encodedPassword: false)
        case .error, .invalidPath, .invalidUrl:
            return LoginRequest(email: "testLoginError", password: "testLoginError", encodedPassword: false)
        }
    }
}
