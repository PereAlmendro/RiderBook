//
//  CircuitRepository.swift
//  RiderBook
//
//  Created by Pere Almendro on 19/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import Combine

protocol CircuitRepositoryProtocol {
    func getCircuits() -> AnyPublisher<[Circuit]?, RiderBookError>
}

final class CircuitRepository: CircuitRepositoryProtocol {
    
    // MARK: - Private properties
    
    private let riderBookApiService: RiderBookApiServiceProtocol
    
    // MARK: - Lifecycle
    
    init(riderBookApiService: RiderBookApiServiceProtocol) {
        self.riderBookApiService = riderBookApiService
    }
    
    // MARK: - CircuitRepositoryProtocol
    
    func getCircuits() -> AnyPublisher<[Circuit]?, RiderBookError> {
        return riderBookApiService.loadRequest(CircuitTarget.getCircuits, responseModel: [CircuitResponse].self)
            .map { (response) -> [Circuit]? in
                return response?.compactMap { CircuitFactory.createCircuit(from: $0) }
        }.eraseToAnyPublisher()
    }
}
