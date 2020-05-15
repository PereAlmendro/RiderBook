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
    case editLap = "/laps/edit"
}

enum LapTarget: ApiTargetProtocol {
    case addLap(_ request: AddLapRequest)
    case lapList(_ request: LapListRequest)
    case deleteLap(_ request: DeleteLapRequest)
    case editLap(_ request: EditLapRequest)
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
        case .editLap:
            return LapEndpoint.editLap.rawValue
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
        case .editLap:
            return .post
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
        case .editLap(let request):
            return request
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .addLap, .deleteLap, .editLap:
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
        case .editLap(let request):
            return ["Content-Type": "application/json", "authorization" : request.authorization]
        }
    }
}
