//
//  LapService.swift
//  RiderBook
//
//  Created by Pere Almendro on 03/05/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import Combine

protocol LapServiceProtocol {
    func addLap(lap: Lap) -> AnyPublisher<Bool, APIProviderError>
    func fetchLaps(page: Int, rideId: Int) -> AnyPublisher<[Lap], APIProviderError>
    func deleteLap(lap: Lap) -> AnyPublisher<Bool, APIProviderError>
    func editLap(lap: Lap) -> AnyPublisher<Bool, APIProviderError>
}

final class LapService {

    private let lapRepository: LapRepositoryProtocol
    private let localRepository: LocalRepositoryProtocol
    private var userAuth: String {
        return localRepository.getUser()?.authorization ?? ""
    }

    init(lapRepository: LapRepositoryProtocol,
         localRepository: LocalRepositoryProtocol) {
        self.lapRepository = lapRepository
        self.localRepository = localRepository
    }
}

extension LapService: LapServiceProtocol {
    
    func addLap(lap: Lap) -> AnyPublisher<Bool, APIProviderError> {
        return lapRepository.addLap(rideId: lap.rideId,
                                    lapTimeInSeconds: lap.timeInSeconds,
                                    number: lap.number,
                                    userAuth: userAuth)
    }
    
    func fetchLaps(page: Int, rideId: Int) -> AnyPublisher<[Lap], APIProviderError> {
        return lapRepository.fetchLaps(page: page,
                                       rideId: rideId,
                                       userAuth: userAuth)
    }
    
    func deleteLap(lap: Lap) -> AnyPublisher<Bool, APIProviderError> {
        return lapRepository.deleteLap(lapId: lap.lapId,
                                       userAuth: userAuth)
    }
    
    func editLap(lap: Lap) -> AnyPublisher<Bool, APIProviderError> {
        return lapRepository.editLap(rideId: lap.rideId,
                                     lapId: lap.lapId,
                                     lapTimeInSeconds: lap.timeInSeconds,
                                     userAuth: userAuth)
    }
}
