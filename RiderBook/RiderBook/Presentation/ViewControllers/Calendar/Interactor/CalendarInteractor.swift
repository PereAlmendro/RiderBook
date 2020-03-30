//
//  CalendarInteractor.swift
//  RiderBook
//
//  Created by Pere Almendro on 27/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import RxSwift

protocol CalendarInteractor {
    func fetchRides() -> Single<[Ride]>
}

class CalendarInteractorImpl: CalendarInteractor {
    
    func fetchRides() -> Single<[Ride]> {
        // TODO: Fetch all rides
        return Single.just(MockData.shared().getRides())
    }
}
