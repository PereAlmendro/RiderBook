//
//  RidesViewNavigationLinks.swift
//  RiderBook
//
//  Created by Pere Almendro on 23/12/20.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import SwiftUI

struct RidesViewNavigationLinks: View {
    @ObservedObject var viewModel: RidesViewModel

    var body: some View {
        switch self.viewModel.navigation {
        case .AddRide:
            NavigationLink(
                destination: AddRideView.instantiate(),
                isActive: .constant(true)) {
                EmptyView()
            }.isDetailLink(false)
        default:
            EmptyView()
        }
    }
}
