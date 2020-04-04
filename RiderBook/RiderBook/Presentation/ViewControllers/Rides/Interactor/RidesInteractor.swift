//
//  RidesInteractor.swift
//  RiderBook
//
//  Created by Pere Almendro on 29/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import RxSwift

protocol RidesInteractor {
    func fetchRides() -> Single<[Ride]>
}

class MyRidesInteractorImpl: RidesInteractor {
    func fetchRides() -> Single<[Ride]> {
        // TODO: Fetch all rides
        return Single.just(MockData.shared().getRides())
    }
}
