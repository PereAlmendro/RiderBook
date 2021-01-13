//
//  APIErrorBuilder.swift
//  RiderBook
//
//  Created by Pere Almendro on 13/1/21.
//  Copyright © 2021 Pere Almendro. All rights reserved.
//

import Foundation
import Combine

struct APIErrorBuilder {
    
    static func makeBadUrlError<ResponseModel: Decodable>(responseModel: ResponseModel.Type)
    -> AnyPublisher<ResponseModel?, APIProviderError> {

        let badUrlError = APIProviderError.badRequest(URLError(.badURL))
        return Result<ResponseModel?, APIProviderError>.Publisher(badUrlError)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
