//
//  Loginview.swift
//  RiderBook
//
//  Created by Pere Almendro on 06/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        LoadingView(isShowing: $viewModel.showLoading) {
            ZStack(alignment: .center) {
                
                Image("login_background")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .center, spacing: 60) {
                    Spacer().frame(height: 30)
                    
                    Text(self.viewModel.screenTitle.localized())
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    
                    CustomButton(title: "log_in_with_google" , action: {
                        // TODO: Action
                    }).accessibility(identifier: "loginWithGoogle")
                    
                    Spacer()
                }
            }
        }
    }
}

#if DEBUG

struct Loginview_Previews: PreviewProvider {
    static let fakeCoordinator = AppCoordinator(window: UIWindow())
    static let loginAssembly = LoginAssembly(coordinator: fakeCoordinator)
    
    static var previews: some View {
        loginAssembly.getView()
    }
}
#endif
