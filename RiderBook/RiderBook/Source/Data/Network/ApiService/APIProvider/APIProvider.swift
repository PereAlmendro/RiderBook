//
//  APIProvider.swift
//  RiderBook
//
//  Created by Pere Almendro on 12/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import Combine

protocol APIProviderProtocol {
    func loadRequest<ResponseModel: Decodable>(_ target: ApiTargetProtocol,
                                               responseModel: ResponseModel.Type)
    -> AnyPublisher<ResponseModel?, APIProviderError>
}

final class APIProvider: APIProviderProtocol {
    
    func loadRequest<ResponseModel: Decodable>(_ target: ApiTargetProtocol,
                                               responseModel: ResponseModel.Type)
    -> AnyPublisher<ResponseModel?, APIProviderError> {

        guard let request = APIRequestBuilder.makeRequestFrom(target: target) else {
            return APIRequestBuilder.getbadUrlError(responseModel: responseModel)
        }

        return URLSession.shared.dataTaskPublisher(for: request)
            .map { data, response in data }
            .mapError { error in APIProviderError.responseError(error) }
            .decode(type: responseModel, decoder: JSONDecoder())
            .mapError { error in APIProviderError.responseError(error) }
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
}
