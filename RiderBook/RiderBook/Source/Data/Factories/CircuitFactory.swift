//
//  CircuitFactory.swift
//  RiderBook
//
//  Created by Pere Almendro on 19/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

protocol CircuitFactoryProtocol {
    static func createCircuit(from circuitResponse: CircuitResponse) -> Circuit?
}

final class CircuitFactory: CircuitFactoryProtocol {
    static func createCircuit(from circuitResponse: CircuitResponse) -> Circuit? {
        return Circuit(id: circuitResponse.id,
                       name: circuitResponse.name,
                       location: circuitResponse.location)
    }
}
