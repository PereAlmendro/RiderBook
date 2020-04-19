//
//  CircuitService.swift
//  RiderBook
//
//  Created by Pere Almendro on 19/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import RxSwift

protocol CircuitServiceProtocol {
    func getCircuits() -> Single<[Circuit]>
}

class CircuitService: CircuitServiceProtocol {
    
    private let circuitRepository: CircuitRepositoryProtocol
    
    init(circuitRepository: CircuitRepositoryProtocol) {
        self.circuitRepository = circuitRepository
    }
    
    func getCircuits() -> Single<[Circuit]> {
        return circuitRepository.getCircuits()
    }
    
}
