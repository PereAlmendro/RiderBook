//
//  LoginPresenter.swift
//  RiderBook
//
//  Created by Pere Almendro on 22/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import RxSwift
import Firebase
import GoogleSignIn

class LoginPresenter: BasePresenter {
    
    // MARK: - Properties
    
    private let loginRouter: LoginRouter
    private let loginInteractor: LoginInteractor
    
    // MARK: - Lyfecycle
    
    init(loginRouter: LoginRouter, loginInteractor: LoginInteractor) {
        self.loginRouter = loginRouter
        self.loginInteractor = loginInteractor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Google Sign in
        GIDSignIn.sharedInstance()?.clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance()?.delegate = self
    }
    
    // MARK: - User Actions
    
    func login(username: String?, password: String?) {
        loginInteractor
            .attemptLogin(username: username, password: password)
            .subscribeOn(SerialDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .showLoader(view: view)
            .subscribe(onSuccess: { [weak self] success in
                if success {
                    self?.loginRouter.showHome()
                } else {
                    self?.view?.showAlert(type: .error,
                                          title: "Error".localized(),
                                          message: "Invalid_login".localized(),
                                          completion: nil)
                }
            }) { [weak self] error in
                self?.view?.showAlert(type: .error,
                                      title: "Error".localized(),
                                      message: error.localizedDescription,
                                      completion: nil)
        }.disposed(by: disposeBag)
    }
    
    func guestButtonAction() {
        loginRouter.showHomeAsGuest()
    }
    
    func loginWithGoogle() {
        GIDSignIn.sharedInstance()?.presentingViewController = view as? UIViewController
        GIDSignIn.sharedInstance().signIn()
    }
}

extension LoginPresenter: GIDSignInDelegate {
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
