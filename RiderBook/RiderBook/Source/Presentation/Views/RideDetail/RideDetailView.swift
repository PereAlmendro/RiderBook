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
        Text("Ride detail")
    }
}

struct RideDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let fakeCoordinator = AppCoordinator(window: UIWindow())
        let rideDetailAssembly = RideDetailAssembly(coordinator: fakeCoordinator)
        return rideDetailAssembly.getView(for: Ride(date: Date(), circuit: "", circuitId: 0, circuitLocation: ""))
    }
}
