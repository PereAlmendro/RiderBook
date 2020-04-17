//
//  LoginViewModel.swift
//  RiderBook
//
//  Created by Pere Almendro on 06/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import SwiftUI
import RxSwift

class LoginViewModel: ObservableObject  {
    
    // MARK: - View properties
    
    @Published var loading: Bool = false
    @Published var email: String = ""
    @Published var password: String = ""
    
    // MARK: - Private properties
    
    private var loginService: LoginServiceProtocol
    private var coordinator: AppCoordinatorProtocol
    private var disposeBag = DisposeBag()
    
    init(loginService: LoginServiceProtocol, coordinator: AppCoordinatorProtocol) {
        self.loginService = loginService
        self.coordinator = coordinator
    }
    
    func signUpAction() {
        loading = true
        loginService
            .logIn(email: email, password: password)
            .subscribeOn(SerialDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] (user) in
                
                self?.loading = false
                guard let user = user else { return }
                print(user)
            
            }) { [weak self] (error) in
            
                self?.loading = false
                guard let error = error as? RiderBookApiServiceError else { return }
                error.getError().printError()
                
        }.disposed(by: disposeBag)
    }
    
    func guestAction() {
        // TODO: continue as guest
    }
}
