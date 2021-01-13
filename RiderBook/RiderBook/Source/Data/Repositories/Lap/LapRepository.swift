//
//  LapRepository.swift
//  RiderBook
//
//  Created by Pere Almendro on 03/05/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import Combine

protocol LapRepositoryProtocol {
    func addLap(rideId: Int, lapTimeInSeconds: String, number: Int, userAuth: String) -> AnyPublisher<Bool, APIProviderError>
    func fetchLaps(page: Int, rideId: Int, userAuth: String) -> AnyPublisher<[Lap], APIProviderError>
    func deleteLap(lapId: Int, userAuth: String) -> AnyPublisher<Bool, APIProviderError>
    func editLap(rideId: Int, lapId: Int, lapTimeInSeconds: String, userAuth: String) -> AnyPublisher<Bool, APIProviderError>
}

final class LapRepository {

    private let apiProvider: APIProvider

    init(apiProvider: APIProvider) {
        self.apiProvider = apiProvider
    }
}

extension LapRepository: LapRepositoryProtocol {

    func addLap(rideId: Int, lapTimeInSeconds: String, number: Int, userAuth: String) -> AnyPublisher<Bool, APIProviderError> {
        let addLapRequest = AddLapRequest(rideId: rideId,
                                          lapTimeInSeconds: lapTimeInSeconds,
                                          number: number,
                                          authorization: userAuth)
        return apiProvider
            .loadRequest(LapTarget.addLap(addLapRequest), responseModel: RiderBookServiceSuccessResponse.self)
            .map { (response) -> Bool in
                return response?.success ?? false
        }.eraseToAnyPublisher()
    }
    
    func fetchLaps(page: Int, rideId: Int, userAuth: String) -> AnyPublisher<[Lap], APIProviderError> {
        let lapListRequest = LapListRequest(page: page, rideId: rideId, authorization: userAuth)
        return apiProvider
            .loadRequest(LapTarget.lapList(lapListRequest), responseModel: LapListResponse.self)
            .map { (response) -> [Lap] in
                guard let laps = response?.laps else {
                    return []
                }
                return laps.compactMap { LapFactory.createLap(from: $0) }
        }.eraseToAnyPublisher()
    }
    
    func deleteLap(lapId: Int, userAuth: String) -> AnyPublisher<Bool, APIProviderError> {
        let deleteLapRequest = DeleteLapRequest(lapId: lapId, authorization: userAuth)
        return apiProvider
            .loadRequest(LapTarget.deleteLap(deleteLapRequest), responseModel: RiderBookServiceSuccessResponse.self)
            .map { (response) -> Bool in
                return response?.success ?? false
        }.eraseToAnyPublisher()
    }
    
    func editLap(rideId: Int, lapId: Int, lapTimeInSeconds: String, userAuth: String) -> AnyPublisher<Bool, APIProviderError> {
        let editLapRequest = EditLapRequest(rideId: rideId,
                                            lapId: lapId,
                                            lapTimeInSeconds: lapTimeInSeconds,
                                            authorization: userAuth)
        return apiProvider
            .loadRequest(LapTarget.editLap(editLapRequest), responseModel: RiderBookServiceSuccessResponse.self)
            .map { (response) -> Bool in
                return response?.success ?? false
        }.eraseToAnyPublisher()
    }
}
