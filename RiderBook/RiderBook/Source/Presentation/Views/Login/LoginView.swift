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
            
            VStack(alignment: .center) {
                
                Text("Rider_book".localized())
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(90)
                
                VStack(alignment: .center, spacing: 20) {
                    
                    CustomTextField(title: "Email",
                                    text: .constant(""),
                                    textFieldPlaceholder: "type email...")
                    
                    CustomTextField(title: "Password",
                                    text: .constant(""),
                                    textFieldPlaceholder: "type password...",
                                    secureField: true)
                    
                    Spacer()
                    
                    CustomButton(title: "register" , action: {
                        self.viewModel.signUpAction()
                    })
                    
                    CustomButton(title: "Join_as_guest" , action: {
                        self.viewModel.guestAction()
                    })
                    
                    Spacer().frame(height: 50)
                    
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
