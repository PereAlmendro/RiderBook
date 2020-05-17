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
    func addLap(rideId: Int, lapTimeInSeconds: String, number: Int, userAuth: String) -> AnyPublisher<Bool, RiderBookError>
    func fetchLaps(page: Int, rideId: Int, userAuth: String) -> AnyPublisher<[Lap], RiderBookError>
    func deleteLap(lapId: Int, userAuth: String) -> AnyPublisher<Bool, RiderBookError>
    func editLap(rideId: Int, lapId: Int, lapTimeInSeconds: String, userAuth: String) -> AnyPublisher<Bool, RiderBookError>
}

final class LapRepository: LapRepositoryProtocol {
    
    // MARK: - Private properties
    
    private let riderBookApiService: RiderBookApiServiceProtocol
    
    // MARK: - Lifecycle
    
    init(riderBookApiService: RiderBookApiServiceProtocol) {
        self.riderBookApiService = riderBookApiService
    }
    
    // MARK: - LapRepositoryProtocol
    
    func addLap(rideId: Int, lapTimeInSeconds: String, number: Int, userAuth: String) -> AnyPublisher<Bool, RiderBookError> {
        let addLapRequest = AddLapRequest(rideId: rideId,
                                          lapTimeInSeconds: lapTimeInSeconds,
                                          number: number,
                                          authorization: userAuth)
        return riderBookApiService
            .loadRequest(LapTarget.addLap(addLapRequest), responseModel: RiderBookServiceSuccessResponse.self)
            .map { (response) -> Bool in
                return response?.success ?? false
        }.eraseToAnyPublisher()
    }
    
    func fetchLaps(page: Int, rideId: Int, userAuth: String) -> AnyPublisher<[Lap], RiderBookError> {
        let lapListRequest = LapListRequest(page: page, rideId: rideId, authorization: userAuth)
        return riderBookApiService
            .loadRequest(LapTarget.lapList(lapListRequest), responseModel: LapListResponse.self)
            .map { (response) -> [Lap] in
                guard let laps = response?.laps else {
                    return []
                }
                return laps.compactMap { LapFactory.createLap(from: $0) }
        }.eraseToAnyPublisher()
    }
    
    func deleteLap(lapId: Int, userAuth: String) -> AnyPublisher<Bool, RiderBookError> {
        let deleteLapRequest = DeleteLapRequest(lapId: lapId, authorization: userAuth)
        return riderBookApiService
            .loadRequest(LapTarget.deleteLap(deleteLapRequest), responseModel: RiderBookServiceSuccessResponse.self)
            .map { (response) -> Bool in
                return response?.success ?? false
        }.eraseToAnyPublisher()
    }
    
    func editLap(rideId: Int, lapId: Int, lapTimeInSeconds: String, userAuth: String) -> AnyPublisher<Bool, RiderBookError> {
        let editLapRequest = EditLapRequest(rideId: rideId,
                                            lapId: lapId,
                                            lapTimeInSeconds: lapTimeInSeconds,
                                            authorization: userAuth)
        return riderBookApiService
            .loadRequest(LapTarget.editLap(editLapRequest), responseModel: RiderBookServiceSuccessResponse.self)
            .map { (response) -> Bool in
                return response?.success ?? false
        }.eraseToAnyPublisher()
    }
    
}
