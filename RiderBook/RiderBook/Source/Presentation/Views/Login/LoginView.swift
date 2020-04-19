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
        LoadingView(isShowing: $viewModel.loading) {
            ZStack(alignment: .center) {
                
                Image("login_background")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .center) {
                    
                    Text("Rider_book".localized())
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(.top, 70)
                        .padding(.bottom, 30)
                    
                    VStack(alignment: .center) {
                        
                        CustomTextField(title: "Email",
                                        text: self.$viewModel.email,
                                        textFieldPlaceholder: "Email")
                        
                        CustomTextField(title: "Password",
                                        text: self.$viewModel.password,
                                        textFieldPlaceholder: "Password",
                                        secureField: true)
                        
                        Spacer()
                        
                        CustomButton(title: "log_in" , action: {
                            self.viewModel.loginAction()
                        })
                        
                        CustomButton(title: "register" , action: {
                            self.viewModel.registerAction()
                        })
                        
                        Spacer().frame(height: 50)
                    }
                }
            }
        }
        .alert(isPresented: $viewModel.showAlert) { () -> Alert in
            Alert(title: Text(viewModel.errorTitle.localized()),
                  message: Text(viewModel.errorMessage),
                  dismissButton: .default(Text("Ok")))
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
