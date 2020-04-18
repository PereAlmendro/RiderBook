//
//  SplashViewModel.swift
//  RiderBook
//
//  Created by Pere Almendro on 18/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import SwiftUI
import RxSwift

class SplashViewModel: ObservableObject  {
    
    // MARK: - Private properties
    
    private var loginService: LoginServiceProtocol
    private var coordinator: AppCoordinatorProtocol
    private var disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    
    init(loginService: LoginServiceProtocol,
         coordinator: AppCoordinatorProtocol) {
        self.loginService = loginService
        self.coordinator = coordinator
        
        attemptAutoLogin()
    }
    
    func attemptAutoLogin() {
        loginService
            .attemptAutologin()
            .subscribeOn(SerialDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self]  (success) in
                success ? self?.coordinator.showHome() : self?.coordinator.showLogin()
            }) { [weak self] (error) in
                self?.coordinator.showLogin()
        }.disposed(by: disposeBag)
    }
}
