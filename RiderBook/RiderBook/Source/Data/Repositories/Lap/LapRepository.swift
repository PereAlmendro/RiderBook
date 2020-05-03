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
    func addLap(rideId: Int, lapTimeInSeconds: String, number: Int) -> AnyPublisher<Bool, RiderBookError>
    func fetchLaps(page: Int, rideId: Int) -> AnyPublisher<[Lap], RiderBookError>
    func deleteLap(lapId: Int) -> AnyPublisher<Bool, RiderBookError>
}

final class LapRepository: LapRepositoryProtocol {
    
    // MARK: - Private properties
    
    private let riderBookApiService: RiderBookApiServiceProtocol
    private let localRepository: LocalRepositoryProtocol
    
    // MARK: - Lifecycle
    
    init(riderBookApiService: RiderBookApiServiceProtocol,
         localRepository: LocalRepositoryProtocol) {
        self.riderBookApiService = riderBookApiService
        self.localRepository = localRepository
    }
    
    // MARK: - LapRepositoryProtocol
    
    func addLap(rideId: Int, lapTimeInSeconds: String, number: Int) -> AnyPublisher<Bool, RiderBookError> {
        let userAuth = localRepository.getUser()?.authorization ?? ""
        let addLapRequest = AddLapRequest(rideId: rideId,
                                          lapTimeInSeconds: lapTimeInSeconds,
                                          number: number,
                                          authorization: userAuth)
        return riderBookApiService
            .loadRequest(LapTarget.addLap(addLapRequest), responseModel: AddLapResponse.self)
            .map { (response) -> Bool in
                return response?.success ?? false
        }.eraseToAnyPublisher()
    }
    
    func fetchLaps(page: Int, rideId: Int) -> AnyPublisher<[Lap], RiderBookError> {
        let userAuth = localRepository.getUser()?.authorization ?? ""
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
    
    func deleteLap(lapId: Int) -> AnyPublisher<Bool, RiderBookError> {
        let userAuth = localRepository.getUser()?.authorization ?? ""
        let deleteLapRequest = DeleteLapRequest(lapId: lapId, authorization: userAuth)
        return riderBookApiService
            .loadRequest(LapTarget.deleteLap(deleteLapRequest), responseModel: DeleteLapResponse.self)
            .map { (response) -> Bool in
                return response?.success ?? false
        }.eraseToAnyPublisher()
    }
    
}
