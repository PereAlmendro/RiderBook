//
//  GoogleSignInProvider.swift
//  RiderBook
//
//  Created by Pere Almendro on 14/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import GoogleSignIn
import RxSwift

class GoogleSignInProvider: NSObject {
    
    // MARK: - Rx bindings
    
    var googleSignInResult: BehaviorSubject<(user: GIDGoogleUser?, error: Error?)> = BehaviorSubject<(user: GIDGoogleUser?, error: Error?)>(value: (nil, nil))
    
    // MARK: - Private properties
    
    private let gidSignIn = GIDSignIn.sharedInstance()
    
    // MARK: - Lifecycle
    
    init(clientID: String) {
        super.init()
        gidSignIn?.clientID = clientID
        gidSignIn?.delegate = self
    }
    
    // MARK: - Public functions
    
    var hasPreviousSignIn: Bool {
        return gidSignIn?.hasPreviousSignIn() ?? false
    }
    
    func restorePreviousLogin() {
        gidSignIn?.presentingViewController = UIApplication.topViewController()
        gidSignIn?.restorePreviousSignIn()
    }
    
    func signIn() {
        gidSignIn?.presentingViewController = UIApplication.topViewController()
        gidSignIn?.signIn()
    }
    
    func signOut() {
        gidSignIn?.disconnect()
    }
    
    // MARK: - Private functions
    
    private func notifySignInResult(with user: GIDGoogleUser?, error: Error?) {
        googleSignInResult.onNext((user: user, error: error))
    }
}

// MARK: - GIDSignInDelegate

extension GoogleSignInProvider: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        notifySignInResult(with: user, error: error)
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        notifySignInResult(with: user, error: error)
    }
}
