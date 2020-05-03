//
//  CircuitTarget.swift
//  RiderBook
//
//  Created by Pere Almendro on 16/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

enum CircuitEndpoint: String  {
    case getCircuits = "/circuits"
}

enum CircuitTarget: ApiTargetProtocol {
    case getCircuits
}

extension CircuitTarget {
    var endPoint: String {
        switch self {
        case .getCircuits:
            return CircuitEndpoint.getCircuits.rawValue
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .getCircuits:
            return .get
        }
    }
}
