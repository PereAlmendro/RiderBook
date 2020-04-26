//
//  Ride.swift
//  RiderBook
//
//  Created by Pere Almendro on 19/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

struct Ride: Identifiable {
    var id = UUID()
    
    let date: Date
    let circuit: String
    let circuitId: Int
    let circuitLocation: String
    
    var dateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        return dateFormatter.string(from: date)
    }
}
