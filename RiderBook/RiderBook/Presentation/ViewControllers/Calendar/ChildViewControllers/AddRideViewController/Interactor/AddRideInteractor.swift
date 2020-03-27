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
        return Single.just([
            "Andalucía Circuit",
            "Ascari Race Resort",
            "Albacete",
            "Alcarrás",
            "Calafat",
            "Circuito Mike G.",
            "Can Padró",
            "Cartagena",
            "ParcMotor Castellolí",
            "Ricardo Tormo Cheste",
            "Fuente Álamo",
            "Jarama",
            "Jerez",
            "Jumilla",
            "Kotarr",
            "La Selva",
            "Llucmajor" ,
            "Máspalomas",
            "Miranda de Ebro",
            "Monteblanco",
            "Montmeló",
            "Móra d’ Ebre",
            "Motorland Aragón",
            "Navarra",
            "San Juan",
            "Tabernas",
            "Torremocha",
            "Villaverde de Medina, Circuito internacional"
        ])
    }
}
