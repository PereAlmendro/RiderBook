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

protocol LoginServiceDelegate: AnyObject {
    func loginComplete(_ success: Bool, isAutoLogin: Bool)
}

protocol LoginService {
    var delegate: LoginServiceDelegate? { get set }
    
    func attemptAutoLogin()
    func signInWithGoogle()
    func signOut()
}

class LoginServiceI: NSObject, LoginService {
    
    private let gidSignIn: GIDSignIn!
    private let userRepository: UserRepository
    private let googleSignInProvider: GoogleSignInProvider
    private var isAutoLogin: Bool = false
    
    weak var delegate: LoginServiceDelegate?
    
    init(gidSignIn: GIDSignIn,
         userRepository: UserRepository,
         googleSignInProvider: GoogleSignInProvider) {
        self.gidSignIn = gidSignIn
        self.userRepository = userRepository
        self.googleSignInProvider = googleSignInProvider
        super.init()
        googleSignInProvider.delegate = self
    }
    
    // MARK: - LoginService
    
    func attemptAutoLogin() {
        isAutoLogin = true
        if googleSignInProvider.hasPreviousSignIn() {
            googleSignInProvider.signIn()
        } else {
            notifyLoginComplete(false)
        }
    }
    
    func signInWithGoogle() {
        googleSignInProvider.signIn()
    }
    
    func signOut() {
        googleSignInProvider.signOut()
    }
    
    private func notifyLoginComplete(_ success: Bool) {
        delegate?.loginComplete(success, isAutoLogin: isAutoLogin)
        isAutoLogin = false
    }
}

// MARK: - GoogleSignInProviderDelegate

extension LoginServiceI: GoogleSignInProviderDelegate {
    
    func didSignIn(with user: GIDGoogleUser?, error: Error?) {
        guard let user = user,
            let authentication = user.authentication else {
            notifyLoginComplete(false)
            return
        }
        
        // firebase signIn
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential) { [weak self] (authResult, error) in
            guard let self = self else { return }
            
            // TODO: Save or do whatever with user data.
            
            self.notifyLoginComplete(true)
        }
    }
}
