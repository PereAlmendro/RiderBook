//
//  RegisterView.swift
//  RiderBook
//
//  Created by Pere Almendro on 18/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import SwiftUI

struct RegisterView: View {
    @ObservedObject var viewModel: RegisterViewModel
    
    var body: some View {
        LoadingView(isShowing: $viewModel.loading) {
            VStack(alignment: .center) {
                List {
                    CustomTextField(title: "Name",
                                    text: self.$viewModel.name,
                                    textFieldPlaceholder: "Name")
                    
                    CustomTextField(title: "Email",
                                    text: self.$viewModel.email,
                                    textFieldPlaceholder: "Email")
                    
                    CustomTextField(title: "Password",
                                    text: self.$viewModel.password,
                                    textFieldPlaceholder: "Password",
                                    secureField: true)
                    
                    CustomTextField(title: "Repeat password",
                                    text: self.$viewModel.repeatedPassword,
                                    textFieldPlaceholder: "Repeat password",
                                    secureField: true)
                }
                
                Spacer()
                
                CustomButton(title: "Register" , action: {
                    self.viewModel.registerAction()
                })
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
struct RegisterView_Previews: PreviewProvider {
    static let fakeCoordinator = AppCoordinator(window: UIWindow())
    static let registerAssembly = RegisterAssembly(coordinator: fakeCoordinator)
    
    static var previews: some View {
        registerAssembly.getView()
    }
}
#endif
