//
//  MockApiService.swift
//  RiderBookTests
//
//  Created by Pere Almendro on 22/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import Combine
@testable import RiderBook

class MockLoginSuccessApiService: RiderBookApiServiceProtocol {
    func loadRequest<ResponseModel: Decodable>(_ target: ApiTargetProtocol, responseModel: ResponseModel.Type)
        -> AnyPublisher<ResponseModel?, RiderBookError> {
            return Result<Int, Error>.Publisher(0)
                .map({ (result) -> ResponseModel? in
                    return UserResponse(id: 11,
                                        email: "test@test.com",
                                        auth: "asoaijdiqwjd aopsidjasopidjasoidjasodjasoidj",
                                        name: "test",
                                        password: "test",
                                        image: nil,
                                        expiryDate: 1587574406) as? ResponseModel
                })
                .mapError({ error in RiderBookError.badRequest(error) })
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
    }
}

class MockNilApiService: RiderBookApiServiceProtocol {
    func loadRequest<ResponseModel: Decodable>(_ target: ApiTargetProtocol, responseModel: ResponseModel.Type)
        -> AnyPublisher<ResponseModel?, RiderBookError> {
            return Result<Int, Error>.Publisher(0)
                .map({ (result) -> ResponseModel? in
                    return nil
                })
                .mapError({ error in RiderBookError.badRequest(error) })
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
    }
}

