//
//  CircuitRepository.swift
//  RiderBook
//
//  Created by Pere Almendro on 19/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import RxSwift

protocol CircuitRepositoryProtocol {
    func getCircuits() -> Single<[Circuit]>
}

class CircuitRepository: CircuitRepositoryProtocol {
    
    private let riderBookApiService: RiderBookApiServiceProtocol
    
    init(riderBookApiService: RiderBookApiServiceProtocol) {
        self.riderBookApiService = riderBookApiService
    }

    func getCircuits() -> Single<[Circuit]> {
        
        return Single.just([])
//        return riderBookApiService
//            .loadRequest(CircuitTarget.getCircuits, responseModel: [CircuitResponse].self)
//            .flatMap({ (result) -> Single<[Circuit]> in
//                guard let circuits = try? result.get() else {
//                    return Single.just([])
//                }
//                return Single.just(
//                    circuits.compactMap({ CircuitFactory.createCircuit(from: $0)  })
//                )
//            })
//            .asSingle()
    }
    
}
