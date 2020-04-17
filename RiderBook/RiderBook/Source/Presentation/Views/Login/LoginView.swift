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
                        .padding(.top, 90)
                        .padding(.bottom, 20)
                    
                    VStack(alignment: .center) {
                        
                        CustomTextField(title: "Email",
                                        text: self.$viewModel.email,
                                        textFieldPlaceholder: "Email")
                        
                        CustomTextField(title: "Password",
                                        text: self.$viewModel.password,
                                        textFieldPlaceholder: "Password",
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
}

#if DEBUG

struct Loginview_Previews: PreviewProvider {
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    static let localRepository = LocalRepository(context: context)
    static let apiService = RiderBookApiService()
    static let userRepository = UserRepository(riderBookApiService: apiService)
    static let loginService = LoginService(userRepository: userRepository, localRepository: localRepository)
    static let fakeCoordinator = AppCoordinator(window: UIWindow(), localRepository: localRepository, loginService: loginService)
    static let loginAssembly = LoginAssembly(coordinator: fakeCoordinator)
    
    static var previews: some View {
        loginAssembly.getView()
    }
}
#endif
