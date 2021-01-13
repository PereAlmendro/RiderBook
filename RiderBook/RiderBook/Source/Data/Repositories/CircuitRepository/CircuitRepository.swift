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
    func getCircuits() -> AnyPublisher<[Circuit]?, APIProviderError>
}

final class CircuitRepository {

    private let apiProvider: APIProvider

    init(apiProvider: APIProvider) {
        self.apiProvider = apiProvider
    }
}

extension CircuitRepository: CircuitRepositoryProtocol {
    
    func getCircuits() -> AnyPublisher<[Circuit]?, APIProviderError> {
        return apiProvider.loadRequest(CircuitTarget.getCircuits, responseModel: [CircuitResponse].self)
            .map { (response) -> [Circuit]? in
                return response?.compactMap { CircuitFactory.createCircuit(from: $0) }
        }.eraseToAnyPublisher()
    }
}
