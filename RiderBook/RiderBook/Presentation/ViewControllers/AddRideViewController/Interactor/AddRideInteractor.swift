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
}

class AddRideInteractorImpl: AddRideInteractor {
    
    func fetchCircuits() -> Single<[String]> {
        return Single.just(MockData.shared().getCircuitNames())
    }
}
