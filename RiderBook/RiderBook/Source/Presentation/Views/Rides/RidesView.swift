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

#if DEBUG
struct RidesView_Previews: PreviewProvider {
    static let fakeCoordinator = AppCoordinator(window: UIWindow())
    static let ridesAssembly = RidesAssembly(coordinator: fakeCoordinator)
    static var previews: some View {
        ridesAssembly.getView()
    }
}
#endif
