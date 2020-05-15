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
    func addLap(lap: Lap) -> AnyPublisher<Bool, RiderBookError>
    func fetchLaps(page: Int, rideId: Int) -> AnyPublisher<[Lap], RiderBookError>
    func deleteLap(lap: Lap) -> AnyPublisher<Bool, RiderBookError>
    func editLap(lap: Lap) -> AnyPublisher<Bool, RiderBookError>
}

final class LapService: LapServiceProtocol {
    
    // MARK: - Private properties
    
    private let lapRepository: LapRepositoryProtocol
    
    // MARK: - Lifecycle
    
    init(lapRepository: LapRepositoryProtocol) {
        self.lapRepository = lapRepository
    }
    
    // MARK: - LapServiceProtocol
    
    func addLap(lap: Lap) -> AnyPublisher<Bool, RiderBookError> {
        return lapRepository.addLap(rideId: lap.rideId, lapTimeInSeconds: lap.timeInSeconds, number: lap.number)
    }
    
    func fetchLaps(page: Int, rideId: Int) -> AnyPublisher<[Lap], RiderBookError> {
        return lapRepository.fetchLaps(page: page, rideId: rideId)
    }
    
    func deleteLap(lap: Lap) -> AnyPublisher<Bool, RiderBookError> {
        return lapRepository.deleteLap(lapId: lap.lapId)
    }
    
    func editLap(lap: Lap) -> AnyPublisher<Bool, RiderBookError> {
        return lapRepository.editLap(rideId: lap.rideId, lapId: lap.lapId, lapTimeInSeconds: lap.timeInSeconds)
    }
}
