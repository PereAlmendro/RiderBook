//
//  LoginPresenter.swift
//  RiderBook
//
//  Created by Pere Almendro on 22/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import RxSwift

class LoginPresenter: BasePresenter {
    
    // MARK: - Properties
    
    private let loginRouter: LoginRouter
    private let loginInteractor: LoginInteractor
    
    // MARK: - Lyfecycle
    
    init(loginRouter: LoginRouter, loginInteractor: LoginInteractor) {
        self.loginRouter = loginRouter
        self.loginInteractor = loginInteractor
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
}
