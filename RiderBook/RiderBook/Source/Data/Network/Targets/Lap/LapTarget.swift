//
//  LapTarget.swift
//  RiderBook
//
//  Created by Pere Almendro on 03/05/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

enum LapEndpoint: String  {
    case new = "/laps/new"
    case lapList = "/laps/list"
    case deleteLap = "/laps/delete"
}

enum LapTarget: ApiTargetProtocol {
    case addLap(_ request: AddLapRequest)
    case lapList(_ request: LapListRequest)
    case deleteLap(_ request: DeleteLapRequest)
}

extension LapTarget {
    var endPoint: String {
        switch self {
        case .addLap:
            return LapEndpoint.new.rawValue
        case .lapList:
            return LapEndpoint.lapList.rawValue
        case .deleteLap:
            return LapEndpoint.deleteLap.rawValue
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .addLap:
            return .put
        case .lapList:
            return .get
        case .deleteLap:
            return .delete
        }
    }
    
    var requestObject: RequestableProtocol? {
        switch self {
        case .addLap(let request):
            return request
        case .lapList:
            return nil
        case .deleteLap(let request):
            return request
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .addLap, .deleteLap:
            return nil
        case .lapList(let request):
            return [URLQueryItem(name: "page", value: String(request.page)),
                    URLQueryItem(name: "rideId", value: String(request.rideId))]
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .addLap(let request):
            return ["Content-Type": "application/json", "authorization" : request.authorization]
        case .lapList(let request):
            return ["Content-Type": "application/json", "authorization" : request.authorization]
        case .deleteLap(let request):
            return ["Content-Type": "application/json", "authorization" : request.authorization]
        }
    }
}
