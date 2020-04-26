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

// MARK: - LoginSuccess

final class MockLoginSuccessApiService: RiderBookApiServiceProtocol {
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

// MARK: - nil result

final class MockNilApiService: RiderBookApiServiceProtocol {
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

// MARK: - GetCircuitsSuccess

final class MockGetCircuitsSuccessApiService: RiderBookApiServiceProtocol {
    func loadRequest<ResponseModel: Decodable>(_ target: ApiTargetProtocol, responseModel: ResponseModel.Type)
        -> AnyPublisher<ResponseModel?, RiderBookError> {
            return Result<Int, Error>.Publisher(0)
                .map({ (result) -> ResponseModel? in
                    var circuits: [CircuitResponse] = []
                    for index in 0 ..< 10 {
                        circuits += [
                            CircuitResponse(id: index, name: "circuitName", location: "42.12313, 2.3123123")
                        ]
                    }
                    return circuits as? ResponseModel
                })
                .mapError({ error in RiderBookError.badRequest(error) })
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
    }
}

// MARK: - AddRideSuccess

final class MockAddRideSuccessApiService: RiderBookApiServiceProtocol {
    func loadRequest<ResponseModel: Decodable>(_ target: ApiTargetProtocol, responseModel: ResponseModel.Type)
        -> AnyPublisher<ResponseModel?, RiderBookError> {
            return Result<Int, Error>.Publisher(0)
                .map({ (result) -> ResponseModel? in
                    return AddRideResponse(success: true) as? ResponseModel
                })
                .mapError({ error in RiderBookError.badRequest(error) })
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
    }
}

// MARK: - AddRideFailure

final class MockAddRideFailureApiService: RiderBookApiServiceProtocol {
    func loadRequest<ResponseModel: Decodable>(_ target: ApiTargetProtocol, responseModel: ResponseModel.Type)
        -> AnyPublisher<ResponseModel?, RiderBookError> {
            return Result<Int, Error>.Publisher(0)
                .map({ (result) -> ResponseModel? in
                    return AddRideResponse(success: false) as? ResponseModel
                })
                .mapError({ error in RiderBookError.badRequest(error) })
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
    }
}

// MARK: - FetchRidesSuccess

final class MockAddFetchRidesSuccessApiService: RiderBookApiServiceProtocol {
    func loadRequest<ResponseModel: Decodable>(_ target: ApiTargetProtocol, responseModel: ResponseModel.Type)
        -> AnyPublisher<ResponseModel?, RiderBookError> {
            return Result<Int, Error>.Publisher(0)
                .map({ (result) -> ResponseModel? in
                    var rides: [RideResponse] = []
                    for index in 0 ..< 10 {
                        rides += [
                            RideResponse(rideId: index, rideDate: "13/01/2020",
                                         circuitId: index,
                                         circuitName: "circuitName",
                                         circuitLocation: "42.12313, 2.3123123")
                        ]
                    }
                    return RideListResponse(totalItemsCount: 3,
                                            actualPage: 1,
                                            itemsPerPage: 6,
                                            totalPages: 1,
                                            rides: rides) as? ResponseModel
                })
                .mapError({ error in RiderBookError.badRequest(error) })
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
    }
}
