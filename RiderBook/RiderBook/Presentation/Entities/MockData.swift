//
//  MockData.swift
//  RiderBook
//
//  Created by Pere Almendro on 30/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

class MockData {
    
    private static let sharedInstance: MockData = MockData()
    static func shared() -> MockData {
        return sharedInstance
    }
    
    func getRides() -> [Ride] {
        let ride1 = Ride(date: Date(timeIntervalSinceNow: 60*60*24*6),
                         circuit: "Alcarrás",
                         bestLapTime: "1' 59''")
        
        let ride2 = Ride(date: Date(timeIntervalSinceNow: 60*60*24*1),
                         circuit: "Montmeló",
                         bestLapTime: "27''")
        
        let ride3 = Ride(date: Date(timeIntervalSinceNow: 60*60*24*24),
                         circuit: "Parcmotor Castellolí",
                         bestLapTime: "")
        
        let ride4 = Ride(date: Date(timeIntervalSinceNow: 60*60*24*10),
                         circuit: "Calafat",
                         bestLapTime: "")
        
        let ride5 = Ride(date: Date(timeIntervalSinceNow: 60*60*24*2),
                         circuit: "Alcarrás",
                         bestLapTime: "35''")
        
        return [ride1, ride2, ride3, ride4, ride5]
    }
    
    func getCircuitNames() -> [String] {
        return [
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
    }
    
}
