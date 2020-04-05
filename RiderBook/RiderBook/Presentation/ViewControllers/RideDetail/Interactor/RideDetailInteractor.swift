//
//  RideDetailInteractor.swift
//  RiderBook
//
//  Created by Pere Almendro on 03/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import RxSwift

protocol RideDetailInteractor {
    func createLap(lap: Lap) -> Single<Bool>
    func editLap(lap: Lap) -> Single<Bool>
    func deleteLap(lap: Lap) -> Single<Bool>
}

class RideDetailInteractorImpl: RideDetailInteractor {
    func createLap(lap: Lap) -> Single<Bool> {
        // TODO: Create lap
        return Single.just(true)
    }
    
    func editLap(lap: Lap) -> Single<Bool> {
        // TODO: Update lap
        return Single.just(true)
    }
    
    func deleteLap(lap: Lap) -> Single<Bool> {
        // TODO Delete Lap
        return Single.just(true)
    }
}
