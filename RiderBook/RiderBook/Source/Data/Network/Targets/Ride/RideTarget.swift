//
//  RideTarget.swift
//  RiderBook
//
//  Created by Pere Almendro on 16/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

struct CreateRideRequest: Encodable, RequestableProtocol {
    let circuitId: String
    let dateTimeStamp: String
    let authorization: String
    
    func toJsonData() -> Data? {
        return ["circuitId" : circuitId,
                "date" : dateTimeStamp ].toJsonData()
    }
}

enum RideEndpoint: String  {
    case addRide = "rides/addRide"
    case ridesList = "rides/ridesList"
}

enum RideTarget: ApiTargetProtocol {
    case addRide(_ request: CreateRideRequest)
}

extension RideTarget {
    var baseUrl: ApiBaseUrl {
        return .riderBookBaseUrl
    }
    
    var endPoint: String {
        switch self {
        case .addRide:
            return RideEndpoint.addRide.rawValue
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .addRide:
            return .put
        }
    }
    
    var requestObject: RequestableProtocol? {
        switch self {
        case .addRide(let request):
            return request
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .addRide(let request):
            return ["Content-Type": "application/json", "authorization" : request.authorization]
        }
    }
}
