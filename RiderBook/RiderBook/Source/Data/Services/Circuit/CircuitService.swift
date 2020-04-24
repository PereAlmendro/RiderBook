//
//  CircuitService.swift
//  RiderBook
//
//  Created by Pere Almendro on 19/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import Combine

protocol CircuitServiceProtocol {
    func getCircuits() -> AnyPublisher<[Circuit]?, RiderBookError>
}

class CircuitService: CircuitServiceProtocol {
    
    private let circuitRepository: CircuitRepositoryProtocol
    
    init(circuitRepository: CircuitRepositoryProtocol) {
        self.circuitRepository = circuitRepository
    }
    
    func getCircuits() -> AnyPublisher<[Circuit]?, RiderBookError> {
        return circuitRepository.getCircuits()
    }
    
}
