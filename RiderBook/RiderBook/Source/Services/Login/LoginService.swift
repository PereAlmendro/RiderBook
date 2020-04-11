//
//  LoginService.swift
//  RiderBook
//
//  Created by Pere Almendro on 08/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import GoogleSignIn

protocol LoginService {
    func loginWithGoogle()
}

class LoginServiceI: NSObject, LoginService {
    
    private let gidSignIn: GIDSignIn!
    
    init(gidSignIn: GIDSignIn) {
        self.gidSignIn = gidSignIn
    }
    
    // MARK: - LoginService
    
    func loginWithGoogle() {
        gidSignIn.clientID = FirebaseApp.app()?.options.clientID
        gidSignIn.delegate = self
        
        gidSignIn.presentingViewController = UIApplication.topViewController()
        gidSignIn.signIn()
    }
}

// MARK: - GIDSignInDelegate

extension LoginServiceI: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        guard let user = user,
            let authentication = user.authentication else {
            // Google login complete
            return
        }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential) { (authResult, error) in
            // Google login complete
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Google login complete
    }
}
