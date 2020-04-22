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
        -> AnyPublisher<ResponseModel?, RiderBookApiServiceError>
}

final class RiderBookApiService: RiderBookApiServiceProtocol {
    func loadRequest<ResponseModel: Decodable>(_ target: ApiTargetProtocol,
                                               responseModel: ResponseModel.Type)
        -> AnyPublisher<ResponseModel?, RiderBookApiServiceError> {
            
            guard let url = URL(string: target.baseUrl.rawValue),
                var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
                    return getbadUrlError(responseModel: responseModel)
            }
            
            urlComponents.path = target.endPoint
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
            
            return URLSession.shared.dataTaskPublisher(for: request)
                .map { data, response in data }
                .mapError { error in RiderBookApiServiceError.responseError(error) }
                .decode(type: responseModel.self, decoder: decoder)
                .mapError { error in RiderBookApiServiceError.responseError(error) }
                .map({ (result) -> ResponseModel? in result })
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
    }
    
    private func getbadUrlError<ResponseModel: Decodable>(responseModel: ResponseModel.Type)
        -> AnyPublisher<ResponseModel?, RiderBookApiServiceError> {
        return Result<Int, Error>.Publisher(URLError(.badURL))
            .map({ response -> ResponseModel? in nil })
            .mapError({ error in RiderBookApiServiceError.badRequest(error) })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
