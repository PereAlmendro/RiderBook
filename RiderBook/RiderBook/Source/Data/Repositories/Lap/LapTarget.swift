//
//  LapTarget.swift
//  RiderBook
//
//  Created by Pere Almendro on 03/05/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

enum LapTarget: ApiTargetProtocol {
    case addLap(_ request: AddLapRequest)
    case lapList(_ request: LapListRequest)
    case deleteLap(_ request: DeleteLapRequest)
    case editLap(_ request: EditLapRequest)
}

extension LapTarget {

    var baseUrl: String {
        return EnvironmentController.shared.urls.baseUrl
    }
    
    var endPoint: String {
        switch self {
        case .addLap:
            return "/laps/new"
        case .lapList:
            return "/laps/list"
        case .deleteLap:
            return "/laps/delete"
        case .editLap:
            return "/laps/edit"
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
