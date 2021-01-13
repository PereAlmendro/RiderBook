//
//  RiderBookApiService.swift
//  RiderBook
//
//  Created by Pere Almendro on 12/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import Combine

protocol RiderBookApiServiceProtocol {
    func loadRequest<ResponseModel: Decodable>(_ target: ApiTargetProtocol,
                                               responseModel: ResponseModel.Type)
    -> AnyPublisher<ResponseModel?, RiderBookError>
}

final class RiderBookApiService: RiderBookApiServiceProtocol {
    func loadRequest<ResponseModel: Decodable>(_ target: ApiTargetProtocol,
                                               responseModel: ResponseModel.Type)
    -> AnyPublisher<ResponseModel?, RiderBookError> {

        guard
            let url = URL(string: target.baseUrl),
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            return getbadUrlError(responseModel: responseModel)
        }

        urlComponents.path = urlComponents.path.appending(target.endPoint)
        urlComponents.queryItems = target.queryItems

        guard let finalUrl = urlComponents.url else {
            return getbadUrlError(responseModel: responseModel)
        }
        var request = URLRequest(url: finalUrl)

        request.httpMethod = target.method.rawValue
        request.allHTTPHeaderFields = target.headers

        if let requestJsonData = target.requestObject?.toJsonData() {
            request.httpBody = requestJsonData
        }

        let decoder = JSONDecoder()

        #if DEBUG
        print("\nREQUEST : ")
        print(request.url?.absoluteString ?? "Empty URL")
        #endif

        return URLSession.shared.dataTaskPublisher(for: request)
            .map { data, response in data }
            .mapError { error in RiderBookError.responseError(error) }
            .decode(type: responseModel, decoder: decoder)
            .mapError { error in RiderBookError.responseError(error) }
            .map({ (result) -> ResponseModel? in
                #if DEBUG
                print("\nRESPONSE : ")
                print(request.url?.absoluteString ?? "Empty URL")
                print(result)
                #endif
                return result
            })
            .eraseToAnyPublisher()
    }
    
    private func getbadUrlError<ResponseModel: Decodable>(responseModel: ResponseModel.Type)
    -> AnyPublisher<ResponseModel?, RiderBookError> {
        let badUrlError = RiderBookError.badRequest(URLError(.badURL))
        return Result<ResponseModel?, RiderBookError>.Publisher(badUrlError)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
