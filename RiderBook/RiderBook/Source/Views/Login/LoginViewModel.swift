//
//  LoginViewModel.swift
//  RiderBook
//
//  Created by Pere Almendro on 06/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import FirebaseAuth
import Combine

class LoginViewModel: ObservableObject  {
    
    // MARK: - View properties
    
    var screenTitle = "Rider_book"
    
    // MARK: - Private properties
    
    private var loginProvider: LoginProvider
    
    init(loginProvider: LoginProvider) {
        self.loginProvider = loginProvider
    }
    
    //MARK: - User actions
    
    func loginWithGoogleAction() {
        loginProvider.loginWithGoogle(delegate: self)
    }
    
}

extension LoginViewModel: LoginProviderDelegate {
    func userLoggedInWithGoogle(_ authResult: AuthDataResult?, error: Error?) {
        if error == nil, let user = authResult?.user {
            // Login successfull
            let user = User(userID: user.uid,
                            name: user.displayName ?? "",
                            photoUrl: user.photoURL?.absoluteString ?? "",
                            email: user.email ?? "",
                            phoneNumber: user.phoneNumber ?? "")
            print(user)
        } else {
            // Handle errors
        }
    }
}
