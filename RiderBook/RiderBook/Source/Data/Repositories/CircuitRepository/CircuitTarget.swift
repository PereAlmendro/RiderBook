//
//  CircuitTarget.swift
//  RiderBook
//
//  Created by Pere Almendro on 16/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

enum CircuitTarget: ApiTargetProtocol {
    case getCircuits
}

extension CircuitTarget {

    var baseUrl: String {
        return EnvironmentController.shared.urls.baseUrl
    }
    var endPoint: String {
        switch self {
        case .getCircuits:
            return "/circuits"
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .getCircuits:
            return .get
        }
    }
}
