//
//  RideListItem.swift
//  RiderBook
//
//  Created by Pere Almendro on 26/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import SwiftUI

struct RideListItem: View {
    var ride: Ride
    
    var body: some View {
        VStack {
            Text(ride.circuit)
            Text(ride.dateString)
        }
    }
}

#if DEBUG
struct RideListItem_Previews: PreviewProvider {
    private static let ride = Ride(date: Date(), circuit: "Alcarrás",
                               circuitId: 4, circuitLocation: "42.12321, -2.23237")
    static var previews: some View {
        RideListItem(ride: ride)
    }
}
#endif
