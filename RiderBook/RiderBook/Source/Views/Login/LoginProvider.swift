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

protocol LoginProviderDelegate: AnyObject {
    func userLoggedInWithGoogle(_ authResult: AuthDataResult?, error: Error?)
}

protocol LoginProvider {
    func loginWithGoogle(delegate: LoginProviderDelegate)
}

class LoginProviderImpl: NSObject, LoginProvider {
    
    private weak var delegate: LoginProviderDelegate?
    
    override init() {
        super.init()
        // Google Sign in
        GIDSignIn.sharedInstance()?.clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance()?.delegate = self
    }
    
    // MARK: - LoginProvider
    
    func loginWithGoogle(delegate: LoginProviderDelegate) {
        self.delegate = delegate
        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.topViewController()
        GIDSignIn.sharedInstance().signIn()
    }
}

// MARK: - GIDSignInDelegate

extension LoginProviderImpl: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        guard let authentication = user.authentication else {
            delegate?.userLoggedInWithGoogle(nil, error: error)
            return
        }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential) { [weak self] (authResult, error) in
            self?.delegate?.userLoggedInWithGoogle(authResult, error: error)
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        delegate?.userLoggedInWithGoogle(nil, error: error)
    }
}
