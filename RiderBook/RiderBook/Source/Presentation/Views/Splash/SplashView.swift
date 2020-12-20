//
//  SplashView.swift
//  RiderBook
//
//  Created by Pere Almendro on 18/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import SwiftUI

struct SplashView: View {
    
    @ObservedObject var viewModel: SplashViewModel
    
    var body: some View {
        Image("login_background")
            .resizable()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                self.viewModel.attemptAutoLogin()
            }

        NavigationLink(
            destination: TabBarView(
                homeView: HomeView.instantiate(),
                ridesView: RidesView.instantiate(),
                profileView: ProfileView.instantiate() ),
            isActive: self.$viewModel.navigateHome) { EmptyView() }

        NavigationLink(
            destination: LoginView.instantiate(),
            isActive: self.$viewModel.navigateLogin) { EmptyView() }
    }
}
