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
                         circuit: getCircuits()[4],
                         bestLap: Lap(name: "Lap 1", time: "1h 1' 34''", isBestLap: false))
        
        let ride2 = Ride(date: Date(timeIntervalSinceNow: 60*60*24*1),
                         circuit: getCircuits()[6],
                         bestLap: Lap(name: "Lap 2", time: "1' 34''", isBestLap: false))
        
        let ride3 = Ride(date: Date(timeIntervalSinceNow: 60*60*24*24),
                         circuit: getCircuits()[8],
                         bestLap: Lap(name: "Lap 3", time: "44''", isBestLap: false))
        
        let ride4 = Ride(date: Date(timeIntervalSinceNow: 60*60*24*10),
                         circuit: getCircuits()[15],
                         bestLap: Lap(name: "Lap 4", time: "38''", isBestLap: false))
        
        let ride5 = Ride(date: Date(timeIntervalSinceNow: 60*60*24*2),
                         circuit: getCircuits()[1],
                         bestLap: Lap(name: "Lap 5", time: "48''", isBestLap: false))
        
        return [ride1, ride2, ride3, ride4, ride5]
    }
    
    func getCircuits() -> [Circuit] {
        return [
            Circuit(name: "Andalucía Circuit", location: nil),
            Circuit(name: "Ascari Race Resort", location: nil),
            Circuit(name: "Albacete", location: nil),
            Circuit(name: "Alcarrás", location: nil),
            Circuit(name: "Calafat", location: nil),
            Circuit(name: "Circuito Mike G.", location: nil),
            Circuit(name: "Can Padró", location: nil),
            Circuit(name: "Cartagena", location: nil),
            Circuit(name: "ParcMotor Castellolí", location: nil),
            Circuit(name: "Ricardo Tormo Cheste", location: nil),
            Circuit(name: "Fuente Álamo", location: nil),
            Circuit(name: "Jarama", location: nil),
            Circuit(name: "Jerez", location: nil),
            Circuit(name: "Jumilla", location: nil),
            Circuit(name: "Kotarr", location: nil),
            Circuit(name: "La Selva", location: nil),
            Circuit(name: "Llucmajor" , location: nil),
            Circuit(name: "Máspalomas", location: nil),
            Circuit(name: "Miranda de Ebro", location: nil),
            Circuit(name: "Monteblanco", location: nil),
            Circuit(name: "Montmeló", location: nil),
            Circuit(name: "Móra d’ Ebre", location: nil),
            Circuit(name: "Motorland Aragón", location: nil),
            Circuit(name: "Navarra", location: nil),
            Circuit(name: "San Juan", location: nil),
            Circuit(name: "Tabernas", location: nil),
            Circuit(name: "Torremocha", location: nil),
            Circuit(name: "Villaverde de Medina, Circuito internacional", location: nil)
        ]
    }
    
}
