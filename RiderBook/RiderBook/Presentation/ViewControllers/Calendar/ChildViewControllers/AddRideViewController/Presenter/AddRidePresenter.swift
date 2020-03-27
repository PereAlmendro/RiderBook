//
//  AddRidePresenter.swift
//  RiderBook
//
//  Created by Pere Almendro on 26/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation


class AddRidePresenter: BasePresenter {
    
    // MARK: - Properties
    
    private let addRideRouter: AddRideRouter
    private let circuitNames: [String] = [
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
    ]
    
    // MARK: - Lifecycle
    
    init(addRideRouter: AddRideRouter) {
        self.addRideRouter = addRideRouter
    }
    
    // MARK: - Public functions
    
    func getCircuitNames() -> [String] {
        return circuitNames
    }
    
    // MARK: - User Actions
    
    func saveAction() {
        addRideRouter.dismiss()
    }
    
}
