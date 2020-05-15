//
//  ProfileView.swift
//  RiderBook
//
//  Created by Pere Almendro on 11/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel

    var body: some View {
        VStack {
            Spacer()
            Button("Logout") {
                self.viewModel.logoutAction()
            }
        }
    }
}

#if DEBUG
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let fakeCoordinator = AppCoordinator(window: UIWindow())
        return ProfileAssembly(coordinator: fakeCoordinator).getView()
    }
}
#endif
