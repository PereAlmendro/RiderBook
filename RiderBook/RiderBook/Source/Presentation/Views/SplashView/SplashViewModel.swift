//
//  SplashViewModel.swift
//  RiderBook
//
//  Created by Pere Almendro on 18/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class SplashViewModel: ObservableObject  {
    
    // MARK: - Private properties
    
    private let loginService: LoginServiceProtocol
    private let coordinator: AppCoordinatorProtocol
    private var cancellables: [AnyCancellable?] = []
    
    // MARK: - Lifecycle
    
    init(loginService: LoginServiceProtocol,
         coordinator: AppCoordinatorProtocol) {
        self.loginService = loginService
        self.coordinator = coordinator
    }
    
    func attemptAutoLogin() {
        guard let autologinRequest = loginService.attemptAutologin() else {
            coordinator.showLogin()
            return
        }
        
        cancellables += [
            autologinRequest.sink(receiveCompletion: { [weak self] (completion) in
                switch completion {
                case .failure:
                    self?.coordinator.showLogin()
                default:
                    return
                }
                }, receiveValue: { [weak self] (success) in
                    success ? self?.coordinator.showHome() : self?.coordinator.showLogin()
            })
        ]
    }
}
