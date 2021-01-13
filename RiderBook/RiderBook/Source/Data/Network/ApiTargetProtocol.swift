//
//  ApiTargetProtocol.swift
//  RiderBook
//
//  Created by Pere Almendro on 12/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

protocol ApiTargetProtocol {
    var baseUrl: String { get }
    var endPoint: String { get }
    var method: HttpMethod { get }
    var headers: [String: String]? { get }
    var requestObject: RequestableProtocol? { get }
    var queryItems: [URLQueryItem]? { get }
}

extension ApiTargetProtocol {
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var requestObject: RequestableProtocol? {
        return nil
    }
    
    var queryItems: [URLQueryItem]? {
        return nil
    }
}
