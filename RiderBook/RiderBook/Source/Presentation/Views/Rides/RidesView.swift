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
            VStack {
                Text("Rides View")
            }.navigationBarItems(trailing:
                Button("Add ride".localized()) {
                self.viewModel.addRideAction()
            })
        }
        
        
    }
}

struct RidesView_Previews: PreviewProvider {
    static let fakeCoordinator = AppCoordinator(window: UIWindow())
    static let ridesAssembly = RidesAssembly(coordinator: fakeCoordinator)
    static var previews: some View {
        ridesAssembly.getView()
    }
}
