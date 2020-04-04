//
//  AddRideInteractor.swift
//  RiderBook
//
//  Created by Pere Almendro on 27/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import RxSwift

protocol AddRideInteractor {
    func fetchCircuits() -> Single<[String]>
    func attemptAddRide(selectedDate: Date, selectedCircuit: String) -> Single<Bool>
}

class AddRideInteractorImpl: AddRideInteractor {
    
    func fetchCircuits() -> Single<[String]> {
        // TODO: Fetch circuits
        return Single.just(MockData.shared().getCircuitNames())
    }
    
    func attemptAddRide(selectedDate: Date, selectedCircuit: String) -> Single<Bool> {
        // TODO: Add a ride
        return Single.just(false)
    }
}
