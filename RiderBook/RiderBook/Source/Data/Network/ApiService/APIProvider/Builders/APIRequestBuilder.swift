//
//  APIRequestBuilder.swift
//  RiderBook
//
//  Created by Pere Almendro on 13/1/21.
//  Copyright © 2021 Pere Almendro. All rights reserved.
//

import Foundation

final class APIRequestBuilder {

    static func makeRequestFrom(target: ApiTargetProtocol) -> URLRequest? {
        guard
            let url = Self.makeUrlFrom(target: target) else {
            return nil
        }

        var request = URLRequest(url: url)

        request.httpMethod = target.method.rawValue
        request.allHTTPHeaderFields = target.headers
        if let requestJsonData = target.requestObject?.toJsonData() {
            request.httpBody = requestJsonData
        }

        #if DEBUG
        print("\nREQUEST : ")
        print(request.url?.absoluteString ?? "Empty URL")
        #endif

        return request
    }
}

private extension APIRequestBuilder {
    static func makeUrlFrom(target: ApiTargetProtocol) -> URL? {
        guard
            let url = URL(string: target.baseUrl),
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            return nil
        }

        urlComponents.path = urlComponents.path.appending(target.endPoint)
        urlComponents.queryItems = target.queryItems

        guard let finalUrl = urlComponents.url else {
            return nil
        }
        return finalUrl
    }
}
