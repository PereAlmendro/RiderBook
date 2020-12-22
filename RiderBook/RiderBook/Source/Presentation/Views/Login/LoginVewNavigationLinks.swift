//
//  LoginVewNavigationLinks.swift
//  RiderBook
//
//  Created by Pere Almendro on 22/12/20.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import SwiftUI

struct LoginVewNavigationLinks: View {
    @ObservedObject var viewModel: LoginViewModel

    var body: some View {
        switch self.viewModel.navigation {
        case .home:
            NavigationLink(
                destination: TabBarView(
                    homeView: HomeView.instantiate(),
                    ridesView: RidesView.instantiate(),
                    profileView: ProfileView.instantiate() ),
                isActive: .constant(true)) { EmptyView() }

        case .register:
            // TODO: - Register screen
            EmptyView()
        default:
            EmptyView()
        }
    }
}
