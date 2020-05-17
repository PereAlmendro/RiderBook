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
    var selectRide: (_ ride: Ride) -> Void
    var editAction: (_ ride: Ride) -> Void
    var deleteAction: (_ ride: Ride) -> Void
    
    var body: some View {
        HStack {
            VStack {
                Text("\(ride.circuit) - \(ride.dateString)")
                    .multilineTextAlignment(.leading)
            }
            
            Spacer()
            
            Image("ic_edit")
                .renderingMode(.template)
                .foregroundColor(Color.dlBlack)
                .padding()
                .onTapGesture {
                self.editAction(self.ride)
            }
            
            Image("ic_delete")
                .renderingMode(.template)
                .foregroundColor(Color.dlBlack)
                .onTapGesture {
                self.deleteAction(self.ride)
            }
        }
        .onTapGesture {
            self.selectRide(self.ride)
        }
    }
}

#if DEBUG
struct RideListItem_Previews: PreviewProvider {
    private static let ride = Ride(id: 0, date: Date(), circuit: "Alcarrás",
                               circuitId: 4, circuitLocation: "42.12321, -2.23237")
    static var previews: some View {
        RideListItem(ride: ride, selectRide: { _ in }, editAction: { _ in }, deleteAction: { _ in } )
    }
}
#endif
