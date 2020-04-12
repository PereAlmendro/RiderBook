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
import RxSwift

protocol LoginService {
    func loginWithGoogle()
    func attemptLogin(email: String, password: String) -> Single<User?>
    func registerUser(name: String,
                      password: String,
                      email: String,
                      imageURL: String) -> Single<User?>
}

class LoginServiceI: NSObject, LoginService {
    
    private let gidSignIn: GIDSignIn!
    private let userRepository: UserRepository
    
    init(gidSignIn: GIDSignIn, userRepository: UserRepository) {
        self.gidSignIn = gidSignIn
        self.userRepository = userRepository
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

// MARK: - RiderBookLogin

extension LoginServiceI {
    
    func attemptLogin(email: String, password: String) -> Single<User?> {
        return userRepository.login(email: email, password: password)
    }
    func registerUser(name: String,
                      password: String,
                      email: String,
                      imageURL: String) -> Single<User?> {
        return userRepository.createUser(name: name,
                                         password: password,
                                         email: email,
                                         imageURL: imageURL)
    }
    
}
