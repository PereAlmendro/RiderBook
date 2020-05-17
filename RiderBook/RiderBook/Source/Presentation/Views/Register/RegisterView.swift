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
            ScrollView {
                VStack(alignment: .center, spacing: 30) {
                    CustomTextField(text: self.$viewModel.name,
                                    leftImageName: "person",
                                    textFieldPlaceholder: "Name")
                    
                    CustomTextField(text: self.$viewModel.email,
                                    leftImageName: "envelope",
                                    textFieldPlaceholder: "Email")
                    
                    CustomTextField(text: self.$viewModel.password,
                                    leftImageName: "lock",
                                    textFieldPlaceholder: "Password",
                                    secureField: true)
                    
                    CustomTextField(text: self.$viewModel.repeatedPassword,
                                    leftImageName: "lock",
                                    textFieldPlaceholder: "Repeat_password",
                                    secureField: true)
                    Spacer()
                    
                    Button("Register") {
                        self.viewModel.registerAction()
                    }.buttonStyle(CustomButtonStyle())
                }.padding(20)
            }
        }
        .navigationBarTitle("Register".localized())
        .alert(isPresented: $viewModel.showAlert) { () -> Alert in
            Alert(title: Text(viewModel.errorTitle.localized()),
                  message: Text(viewModel.errorMessage),
                  dismissButton: .default(Text("Ok")))
        }
    }
}
