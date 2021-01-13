//
//  RideTarget.swift
//  RiderBook
//
//  Created by Pere Almendro on 16/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

enum RideTarget: ApiTargetProtocol {
    case addRide(_ request: AddRideRequest)
    case rideList(_ request: RideListRequest)
    case deleteRide(_ request: DeleteRideRequest)
    case editRide(_ request: EditRideRequest)
}

extension RideTarget {
    var endPoint: String {
        switch self {
        case .addRide:
            return "/rides/new"
        case .rideList:
            return "/rides/list"
        case .deleteRide:
            return "/rides/delete"
        case .editRide:
            return "/rides/edit"
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
        case .editRide:
            return .post
        }
    }
    
    var requestObject: RequestableProtocol? {
        switch self {
        case .addRide(let request):
            return request
        case .deleteRide(let request):
            return request
        case .editRide(let request):
            return request
        default:
            return nil
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .rideList(let request):
            return [URLQueryItem(name: "page", value: String(request.page))]
        default:
            return nil
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
        case .editRide(let request):
            return ["Content-Type": "application/json", "authorization" : request.authorization]
        }
    }
}
