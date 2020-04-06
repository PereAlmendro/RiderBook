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
    func fetchCircuits() -> Single<[Circuit]>
    func attemptAddRide(selectedDate: Date, selectedCircuit: String) -> Single<Bool>
}

class AddRideInteractorImpl: AddRideInteractor {
    
    func fetchCircuits() -> Single<[Circuit]> {
        // TODO: Fetch circuits
        return Single.just(MockData.shared().getCircuits())
    }
    
    func attemptAddRide(selectedDate: Date, selectedCircuit: String) -> Single<Bool> {
        // TODO: Add a ride
        return Single.just(false)
    }
}
