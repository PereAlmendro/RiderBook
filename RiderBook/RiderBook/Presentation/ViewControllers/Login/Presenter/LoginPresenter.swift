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
        view?.showLoader()
        loginInteractor
            .attemptLogin(username: username, password: password)
            .subscribeOn(SerialDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] success in
                if success {
                    self?.loginRouter.showHome()
                } else {
                    // TODO: Handle error
                }
                self?.view?.hideLoader()
            }) { [weak self] error in
                // TODO: Handle error
                self?.view?.hideLoader()
        }.disposed(by: disposeBag)
    }
    
    func guestButtonAction() {
        loginRouter.showHomeAsGuest()
    }
}
