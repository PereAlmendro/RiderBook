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
    }
}

struct SplashView_Previews: PreviewProvider {
    static let fakeCoordinator = AppCoordinator(window: UIWindow())
    static let splashAssembly = SplashAssembly(coordinator: fakeCoordinator)
    static var previews: some View {
        splashAssembly.getView()
    }
}
