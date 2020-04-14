//
//  GoogleSignInProvider.swift
//  RiderBook
//
//  Created by Pere Almendro on 14/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import GoogleSignIn

protocol GoogleSignInProviderDelegate: AnyObject {
    func didSignIn(with user: GIDGoogleUser?, error: Error?)
}

class GoogleSignInProvider: NSObject {
    
    private let gidSignIn = GIDSignIn.sharedInstance()
    weak var delegate: GoogleSignInProviderDelegate?
    
    init(clientID: String) {
        super.init()
        gidSignIn?.clientID = clientID
        gidSignIn?.delegate = self
    }
    
    func signIn() {
        guard let gidSignIn = gidSignIn else { return }
        
        gidSignIn.presentingViewController = UIApplication.topViewController()
        
        if gidSignIn.hasPreviousSignIn() {
            gidSignIn.restorePreviousSignIn()
        } else {
            gidSignIn.signIn()
        }
    }
}

// MARK: - GIDSignInDelegate

extension GoogleSignInProvider: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        delegate?.didSignIn(with: user, error: error)
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        delegate?.didSignIn(with: user, error: error)
    }
    
    
}
