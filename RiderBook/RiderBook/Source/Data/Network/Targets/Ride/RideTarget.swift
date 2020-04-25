//
//  RideTarget.swift
//  RiderBook
//
//  Created by Pere Almendro on 16/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

enum RideEndpoint: String  {
    case addRide = "/RiderBookBackend/symfony/web/rides/addRide"
    case ridesList = "/RiderBookBackend/symfony/web/rides/ridesList"
}

enum RideTarget: ApiTargetProtocol {
    case addRide(_ request: AddRideRequest)
    case rideList(_ request: RideListRequest)
}

extension RideTarget {
    var baseUrl: ApiHostUrl {
        return .riderBook
    }
    
    var endPoint: String {
        switch self {
        case .addRide:
            return RideEndpoint.addRide.rawValue
        case .rideList:
            return RideEndpoint.ridesList.rawValue
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .addRide:
            return .put
        case .rideList:
            return .get
        }
    }
    
    var requestObject: RequestableProtocol? {
        switch self {
        case .addRide(let request):
            return request
        case .rideList:
            return nil
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .addRide:
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
        }
    }
}
