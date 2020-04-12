//
//  ApiTarget.swift
//  RiderBook
//
//  Created by Pere Almendro on 12/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

enum ApiBaseUrl: String {
    case riderBookBaseUrl = "http://192.168.0.19/RiderBook/symfony/web/"
}

enum HttpMethod: String {
    case get = "get"
    case post = "post"
}

protocol Requestable {
    func toJsonData() -> Data?
}

protocol ApiTarget {
    var baseUrl: ApiBaseUrl { get }
    var endPoint: String { get }
    var method: HttpMethod { get }
    var url: URL? { get }
    var headers: [String: String]? { get }
    var requestObject: Requestable? { get }
}

extension ApiTarget {
    var url: URL? {
        return URL(string: baseUrl.rawValue.appending(endPoint))
    }
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    var requestObject: Requestable? {
        return nil
    }
}
