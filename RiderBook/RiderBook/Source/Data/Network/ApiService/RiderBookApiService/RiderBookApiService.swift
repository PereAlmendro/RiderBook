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
            
            guard let url = URL(string: target.baseUrl.rawValue),
                var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
                    return getbadUrlError(responseModel: responseModel)
            }
            
            urlComponents.path = target.basePath.rawValue.appending(target.endPoint)
            urlComponents.queryItems = target.queryItems
            
            guard let finalUrl = urlComponents.url else {
                return getbadUrlError(responseModel: responseModel)
            }
            var request = URLRequest(url: finalUrl)
            
            request.httpMethod = target.method.rawValue
            request.allHTTPHeaderFields = target.headers
            
            #if DEBUG
            print("START SERVICE REQUEST : ")
            print(request.url?.absoluteString ?? "Empty URL")
            #endif
            
            let decoder = JSONDecoder()
            
            if let requestJsonData = target.requestObject?.toJsonData() {
                request.httpBody = requestJsonData
                #if DEBUG
                print("httpBody : ")
                print(target.requestObject as Any)
                #endif
            }
            
            return URLSession.shared.dataTaskPublisher(for: request)
                .map { data, response in
                    #if DEBUG
                    print("RESPONSE : ")
                    print(response)
                    #endif
                    return data
            }
            .mapError { error in RiderBookError.responseError(error) }
            .decode(type: responseModel, decoder: decoder)
            .mapError { error in RiderBookError.responseError(error) }
            .map({ (result) -> ResponseModel? in
                #if DEBUG
                print(result)
                #endif
                return result
            }).eraseToAnyPublisher()
    }
    
    private func getbadUrlError<ResponseModel: Decodable>(responseModel: ResponseModel.Type)
        -> AnyPublisher<ResponseModel?, RiderBookError> {
            return Result<Int, Error>.Publisher(URLError(.badURL))
                .map({ response -> ResponseModel? in nil })
                .mapError({ error in RiderBookError.badRequest(error) })
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
    }
}
