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
            
            RideListItem(ride: viewModel.ride) { _ in }
            
            Button("Add lap") {
                self.viewModel.addLapAction()
            }.foregroundColor(Color.blue)
            
            ForEach(self.viewModel.laps, id: \.self) { lap in
                LapListItem(lap: lap,
                            editAction: { lap in
                                self.viewModel.editLapAction(lap)
                },
                            deleteAction: { lap in
                                self.viewModel.deleteLapAction(lap)
                })
            }
        }
        .navigationBarItems(leading:
            Image("ic_close").onTapGesture {
                self.viewModel.closeAction()
            }, trailing:
            HStack {
                Image("ic_edit").onTapGesture {
                    self.viewModel.editRideAction()
                }.padding()
                Image("ic_delete").onTapGesture {
                    self.viewModel.deleteRideAction()
                }
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
