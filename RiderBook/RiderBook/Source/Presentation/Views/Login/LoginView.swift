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
            ScrollView {
                VStack(alignment: .center, spacing: 30.0) {
                    Text("Rider_book".localized())
                        .foregroundColor(Color.dlBlack)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 30)
                    CustomTextField(text: self.$viewModel.email,
                                    leftImageName: "envelope",
                                    textFieldPlaceholder: "Email")
                    CustomTextField(text: self.$viewModel.password,
                                    leftImageName: "lock",
                                    textFieldPlaceholder: "Password",
                                    secureField: true)
                    Button("log_in") {
                        self.viewModel.loginAction()
                    }.buttonStyle(CustomButtonStyle())
                    Text("Login_advice")
                        .multilineTextAlignment(.center)
                    Spacer()
                    Text("Or")
                    Button("Register") {
                        self.viewModel.registerAction()
                    }.buttonStyle(CustomButtonStyle())
                    Spacer()
                }.padding(.horizontal, 20.0)
            }
        }
        .background(Color.dlBackgroundWhite)
        .navigationBarTitle("Welcome".localized())
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
