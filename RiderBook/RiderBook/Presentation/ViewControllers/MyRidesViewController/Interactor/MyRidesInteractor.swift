//
//  MyRidesInteractor.swift
//  RiderBook
//
//  Created by Pere Almendro on 29/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import RxSwift

protocol MyRidesInteractor {
    func fetchRides() -> Single<[Ride]>
}

class MyRidesInteractorImpl: MyRidesInteractor {
    func fetchRides() -> Single<[Ride]> {
        // TODO: Fetch all rides
        let ride1 = Ride(date: Date(timeIntervalSinceNow: 60*60*24*6),
                         circuit: "Alcarrás")
        
        let ride2 = Ride(date: Date(timeIntervalSinceNow: 60*60*24*1),
                         circuit: "Alcarrás")
        
        let ride3 = Ride(date: Date(timeIntervalSinceNow: 60*60*24*24),
                         circuit: "Alcarrás")
        
        let ride4 = Ride(date: Date(timeIntervalSinceNow: 60*60*24*10),
                         circuit: "Alcarrás")
        
        let ride5 = Ride(date: Date(timeIntervalSinceNow: 60*60*24*2),
                         circuit: "Alcarrás")
        
        return Single.just([ride1, ride2, ride3, ride4, ride5])
    }
}
