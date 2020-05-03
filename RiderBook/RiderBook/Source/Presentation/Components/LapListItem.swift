//
//  LapListItem.swift
//  RiderBook
//
//  Created by Pere Almendro on 03/05/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import SwiftUI

struct LapListItem: View {
    var lap: Lap
    var editAction: (_ lap: Lap) -> Void
    var deleteAction: (_ lap: Lap) -> Void
    
    var body: some View {
        HStack {
            Text("\(lap.number) -> \(lap.getFormattedTime())")
            
            Spacer()

            Image("ic_edit").onTapGesture {
                self.editAction(self.lap)
            }.padding()
            Image("ic_delete").onTapGesture {
                self.deleteAction(self.lap)
            }
        }
    }
}

struct LapListItem_Previews: PreviewProvider {
    static var previews: some View {
        LapListItem(lap: Lap(rideId: 0, lapId: 0, number: 0, timeInSeconds: ""),
                    editAction: { _ in } ,
                    deleteAction: { _ in })
    }
}
