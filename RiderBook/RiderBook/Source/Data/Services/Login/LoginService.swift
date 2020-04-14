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
}

class LoginServiceI: NSObject, LoginService {
    
    private let gidSignIn: GIDSignIn!
    private let userRepository: UserRepository
    private var isAutoLogin: Bool = false
    
    weak var delegate: LoginServiceDelegate?
    
    init(gidSignIn: GIDSignIn, userRepository: UserRepository) {
        self.gidSignIn = gidSignIn
        self.userRepository = userRepository
    }
    
    // MARK: - LoginService
    
    func attemptAutoLogin() {
        isAutoLogin = true
        signInWithGoogle()
    }
    
    func signInWithGoogle() {
        guard let clientId = FirebaseApp.app()?.options.clientID else {
            delegate?.loginComplete(false, isAutoLogin: isAutoLogin)
            return
        }
        
        let googleSingInProvider = GoogleSignInProvider(clientID: clientId)
        googleSingInProvider.delegate = self
        googleSingInProvider.signIn()
    }
}

// MARK: - GIDSignInDelegate

extension LoginServiceI: GoogleSignInProviderDelegate {
    
    func didSignIn(with user: GIDGoogleUser?, error: Error?) {
        guard let user = user,
            let authentication = user.authentication else {
            delegate?.loginComplete(false, isAutoLogin: isAutoLogin)
            return
        }
        
        // firebase signIn
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential) { [weak self] (authResult, error) in
            guard let self = self else { return }
            // TODO: Save or do whatever with user data.
            
            self.delegate?.loginComplete(true, isAutoLogin: self.isAutoLogin)
        }
    }
}
