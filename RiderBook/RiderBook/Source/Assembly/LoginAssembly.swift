//
//  ViewAssembly.swift
//  RiderBook
//
//  Created by Pere Almendro on 11/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import GoogleSignIn
import Firebase

class LoginAssembly {
    private let coordinator: AppCoordinatorProtocol
    
    init(coordinator: AppCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func getView() -> LoginView {
        let riderBookApiService = RiderBookApiService()
        let userRepository = UserRepository(riderBookApiService: riderBookApiService)
        let googleSignInProvider = GoogleSignInProvider(clientID: FirebaseApp.app()?.options.clientID ?? "")
        let loginService = LoginService(gidSignIn: GIDSignIn.sharedInstance(),
                                        userRepository: userRepository,
                                        googleSignInProvider: googleSignInProvider)
        let loginViewModel = LoginViewModel(loginService: loginService, coordinator: coordinator)
        return LoginView(viewModel: loginViewModel)
    }
}
