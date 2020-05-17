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
            Section(header: Text("Circuit_and_date".localized()).foregroundColor(Color.dlBlack)) {
                Text("\(viewModel.ride.circuit) - \(viewModel.ride.dateString)")
                    .multilineTextAlignment(.center)
            }
            
            Section(header: Text("Laps".localized()).foregroundColor(Color.dlBlack)) {
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
        }
        .listStyle(GroupedListStyle())
        .navigationBarItems(leading:
            Image("ic_close")
                .renderingMode(.template)
                .foregroundColor(Color.dlBlack)
                .frame(width: 30, height: 30, alignment: .center)
                .onTapGesture {
                    self.viewModel.closeAction()
            }, trailing:
            
            Button("Add_lap".localized()) {
                self.viewModel.lapAction(.add)
            }
            .foregroundColor(Color.blue))
        .onAppear(perform: {
            self.viewModel.refreshList()
        })
    }
}
