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

protocol LoginServiceProtocol {
    
    var loginResult: BehaviorSubject<(success: Bool, isAutoLogin: Bool)> { get }
    
    func attemptAutoLogin()
    func signInWithGoogle()
    func signOut()
}

class LoginService: NSObject, LoginServiceProtocol {
    
    // MARK: - Rx bindings
    
    var loginResult = BehaviorSubject<(success: Bool, isAutoLogin: Bool)>(value: (false, false))
    
    // MARK: - Private properties
    
    private let gidSignIn: GIDSignIn!
    private let userRepository: UserRepositoryProtocol
    private let googleSignInProvider: GoogleSignInProvider
    private var isAutoLogin: Bool = false
    private var disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    
    init(gidSignIn: GIDSignIn,
         userRepository: UserRepositoryProtocol,
         googleSignInProvider: GoogleSignInProvider) {
        self.gidSignIn = gidSignIn
        self.userRepository = userRepository
        self.googleSignInProvider = googleSignInProvider
        super.init()
        self.setupSignInProviderBinding()
    }
    
    // MARK: - Public functions
    
    func attemptAutoLogin() {
        isAutoLogin = true
        if googleSignInProvider.hasPreviousSignIn {
            googleSignInProvider.restorePreviousLogin()
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
    
    // MARK: - Private functions
    
    private func notifyLoginComplete(_ success: Bool) {
        loginResult.onNext((success: success, isAutoLogin: isAutoLogin))
        isAutoLogin = false
    }
    
    private func performFirebaseLogin(with credentials: AuthCredential) {
        Auth.auth().signIn(with: credentials) { [weak self] (authResult, error) in
            guard let self = self else { return }
            
            // TODO: LogIn to my backend creating user if not exists
            
            self.notifyLoginComplete(true)
        }
    }
    
    private func setupSignInProviderBinding() {
        googleSignInProvider
            .googleSignInResult
            .subscribe { [weak self] (event) in
                guard let (user, _) = event.element,
                    let authentication = user?.authentication else {
                        self?.notifyLoginComplete(false)
                        return
                }
                
                // Firebase signIn
                let credentials = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                                accessToken: authentication.accessToken)
                self?.performFirebaseLogin(with: credentials)
        }.disposed(by: disposeBag)
    }
}
