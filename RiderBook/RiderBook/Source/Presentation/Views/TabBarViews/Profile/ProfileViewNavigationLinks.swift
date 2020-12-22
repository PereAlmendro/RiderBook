//
//  ProfileViewNavigationLinks.swift
//  RiderBook
//
//  Created by Pere Almendro on 22/12/20.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import SwiftUI

struct ProfileViewNavigationLinks: View {
    @ObservedObject var viewModel: ProfileViewModel

    var body: some View {
        switch self.viewModel.navigation {
        case .login:
            NavigationLink(
                destination: LoginView.instantiate(),
                isActive: .constant(true)) { EmptyView() }
        default:
            EmptyView()
        }
    }
}
