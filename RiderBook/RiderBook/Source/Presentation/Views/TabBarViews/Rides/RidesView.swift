//
//  RidesView.swift
//  RiderBook
//
//  Created by Pere Almendro on 11/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import SwiftUI

struct RidesView: View {
    @ObservedObject var viewModel: RidesViewModel
    
    var body: some View {
        RidesViewNavigationLinks(viewModel: viewModel)

        NavigationView {
            List {
                ForEach(self.viewModel.rides, id: \.self) { ride in
                    RideListItem(ride: ride, selectRide: { ride in
                        self.viewModel.selectedRide(ride)
                    }, editAction: { ride in
                        self.viewModel.editRideAction(ride)
                    }, deleteAction: { ride in
                        self.viewModel.showAlertToDeleteRide(ride)
                    })
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("rides".localized())
            .navigationBarItems(trailing:
                Button("Add ride".localized()) {
                    self.viewModel.addRideAction()
            })
        }
        .onAppear {
                self.viewModel.refreshList()
        }
    }
}
