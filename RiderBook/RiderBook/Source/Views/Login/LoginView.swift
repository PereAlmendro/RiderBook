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
        ZStack(alignment: .center) {
            
            Image("login_background")
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center, spacing: 60) {
                Spacer().frame(height: 30)
                
                Text(viewModel.screenTitle.localized())
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                CustomButton(title: "log_in_with_google" , action: {
                    self.viewModel.loginWithGoogleAction()
                }).accessibility(identifier: "loginWithGoogle")
                
                Spacer()
            }
        }
    }
}

#if DEBUG
struct Loginview_Previews: PreviewProvider {
    static var loginViewModel: LoginViewModel {
        return LoginViewModel(loginProvider: LoginProviderImpl())
    }
    
    static var previews: some View {
        LoginView(viewModel: loginViewModel)
    }
}
#endif
