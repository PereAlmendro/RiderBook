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
        var laps = getLaps()
        let ride1 = Ride(date: Date(timeIntervalSinceNow: 60*60*24*6),
                         circuit: getCircuits()[4],
                         bestLap: laps.first(where: { $0.isBestLap })!,
                         laps: getLaps())
        
        laps = getLaps()
        let ride2 = Ride(date: Date(timeIntervalSinceNow: 60*60*24*1),
                         circuit: getCircuits()[6],
                         bestLap: laps.first(where: { $0.isBestLap })!,
                         laps: getLaps())
        
        laps = getLaps()
        let ride3 = Ride(date: Date(timeIntervalSinceNow: 60*60*24*24),
                         circuit: getCircuits()[8],
                         bestLap: laps.first(where: { $0.isBestLap })!,
                         laps: getLaps())
        
        laps = getLaps()
        let ride4 = Ride(date: Date(timeIntervalSinceNow: 60*60*24*10),
                         circuit: getCircuits()[15],
                         bestLap: laps.first(where: { $0.isBestLap })!,
                         laps: getLaps())
        
        laps = getLaps()
        let ride5 = Ride(date: Date(timeIntervalSinceNow: 60*60*24*2),
                         circuit: getCircuits()[1],
                         bestLap: laps.first(where: { $0.isBestLap })!,
                         laps: getLaps())
        
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
    
    func getLaps() -> [Lap] {
        var laps: [Lap] = []
        let randoom = Int.random(in: 0...18)
        var bestLap = true
        for index in 0...randoom {
            let name = "index \(index)"
            let minutes = Int.random(in: 0...1)
            let seconds = Int.random(in: 0...59)
            laps.append(Lap(name: name, time: "\(minutes)' \(seconds)''", isBestLap: bestLap))
            bestLap = false
        }
        return laps.shuffled()
    }
    
}
