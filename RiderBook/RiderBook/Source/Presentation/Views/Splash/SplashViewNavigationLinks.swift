//
//  SplashViewWireFrame.swift
//  RiderBook
//
//  Created by Pere Almendro on 21/12/20.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import SwiftUI

struct SplashViewNavigationLinks: View {
    @ObservedObject var viewModel: SplashViewModel

    var body: some View {
        switch self.viewModel.navigation {
        case .home(let title):
            NavigationLink(
                destination: TabBarView(
                    homeView: HomeView.instantiate(title: title),
                    ridesView: RidesView.instantiate(),
                    profileView: ProfileView.instantiate() ),
                isActive: .constant(true)) { EmptyView() }

        case .login:
            NavigationLink(
                destination: LoginView.instantiate(),
                isActive: .constant(true)) { EmptyView() }
        default:
            EmptyView()
        }
    }
}
