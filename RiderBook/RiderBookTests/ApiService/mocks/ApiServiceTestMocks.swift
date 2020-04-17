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
    case Invalid = ""
    case valid = "user/login"
}

enum MockTarget: ApiTargetProtocol {
    case errorDomain
    case success
    case error
    case invalidUrl
}

extension MockTarget {
    var url: URL? {
        switch self {
        case .invalidUrl:
            return nil
        case .errorDomain:
            return URL(string: "www.testAbsolutelyAFakeDomain.com")
        case .success, .error:
            return URL(string: baseUrl.rawValue.appending(endPoint))
        }
    }
    
    var baseUrl: ApiBaseUrl {
        return .riderBookBaseUrl
    }
    
    var endPoint: String {
        switch self {
        case .success, .error:
            return MockEndpoints.valid.rawValue
        case .errorDomain, .invalidUrl:
            return MockEndpoints.Invalid.rawValue
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
        case .error:
            return LoginRequest(email: "testLoginError", password: "testLoginError", encodedPassword: false)
        case .errorDomain, .invalidUrl:
            return LoginRequest(email: "testLoginError", password: "testLoginError", encodedPassword: false)
        }
    }
}
