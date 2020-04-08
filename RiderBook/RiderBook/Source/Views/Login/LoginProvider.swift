//
//  LoginProvider.swift
//  RiderBook
//
//  Created by Pere Almendro on 08/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import GoogleSignIn

protocol LoginProvider {
    func loginWithGoogle()
}

class LoginProviderImpl: NSObject, LoginProvider {
    
    override init() {
        super.init()
        // Google Sign in
        GIDSignIn.sharedInstance()?.clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance()?.delegate = self
    }
    
    // MARK: - LoginProvider
    
    func loginWithGoogle() {
        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.topViewController()
        GIDSignIn.sharedInstance().signIn()
    }
}

// MARK: - GIDSignInDelegate

extension LoginProviderImpl: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        guard let authentication = user.authentication else {
            // Not authenticated
            return
        }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if error == nil {
                // User logged in
            }
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Sign in interrupted
    }
}
