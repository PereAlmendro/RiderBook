//
//  HomeInteractor.swift
//  RiderBook
//
//  Created by Pere Almendro on 27/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import RxSwift

protocol HomeInteractor {
    func fetchLastRide() -> Single<Ride?>
}

class HomeInteractorImpl: HomeInteractor {
    func fetchLastRide() -> Single<Ride?> {
        // TODO: Fetch the events for the current user
        return Single.just(MockData.shared().getRides().first)
    }
}
