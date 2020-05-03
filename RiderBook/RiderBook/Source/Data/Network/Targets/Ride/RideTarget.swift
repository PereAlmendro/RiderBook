//
//  RideTarget.swift
//  RiderBook
//
//  Created by Pere Almendro on 16/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

enum RideEndpoint: String  {
    case addRide = "/rides/new"
    case ridesList = "/rides/list"
    case deleteRide = "/rides/delete"
}

enum RideTarget: ApiTargetProtocol {
    case addRide(_ request: AddRideRequest)
    case rideList(_ request: RideListRequest)
    case deleteRide(_ request: DeleteRideRequest)
}

extension RideTarget {
    var endPoint: String {
        switch self {
        case .addRide:
            return RideEndpoint.addRide.rawValue
        case .rideList:
            return RideEndpoint.ridesList.rawValue
        case .deleteRide:
            return RideEndpoint.deleteRide.rawValue
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .addRide:
            return .put
        case .rideList:
            return .get
        case .deleteRide:
            return .delete
        }
    }
    
    var requestObject: RequestableProtocol? {
        switch self {
        case .addRide(let request):
            return request
        case .rideList:
            return nil
        case .deleteRide(let request):
            return request
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .addRide, .deleteRide:
            return nil
        case .rideList(let request):
            return [URLQueryItem(name: "page", value: String(request.page))]
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .addRide(let request):
            return ["Content-Type": "application/json", "authorization" : request.authorization]
        case .rideList(let request):
            return ["Content-Type": "application/json", "authorization" : request.authorization]
        case .deleteRide(let request):
            return ["Content-Type": "application/json", "authorization" : request.authorization]
        }
    }
}
