//
//  RideDetailView.swift
//  RiderBook
//
//  Created by Pere Almendro on 03/05/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import SwiftUI

struct RideDetailView: View {
    @ObservedObject var viewModel: RideDetailViewModel
    
    var body: some View {
        List {
            Text("\(viewModel.ride.circuit) - \(viewModel.ride.dateString)")
                .padding()
            
            Button("Add lap") {
                self.viewModel.lapAction(.add)
            }.foregroundColor(Color.blue)
            
            ForEach(self.viewModel.laps, id: \.self) { lap in
                LapListItem(lap: lap,
                            editAction: { lap in
                                self.viewModel.lapAction(.edit, lap: lap)
                },
                            deleteAction: { lap in
                                self.viewModel.lapAction(.delete, lap: lap)
                })
            }
        }
        .navigationBarItems(leading:
            Image("ic_close").onTapGesture {
                self.viewModel.closeAction()
            })
            .onAppear(perform: {
                self.viewModel.refreshList()
            })
        
    }
}

struct RideDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let fakeCoordinator = AppCoordinator(window: UIWindow())
        let rideDetailAssembly = RideDetailAssembly(coordinator: fakeCoordinator)
        return rideDetailAssembly.getView(for: Ride(id: 0, date: Date(), circuit: "", circuitId: 0, circuitLocation: ""))
    }
}
