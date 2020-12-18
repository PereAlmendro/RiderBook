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

protocol SplashViewModelProtocol: AnyObject {
    func attemptAutoLogin()
}

final class SplashViewModel: ObservableObject, SplashViewModelProtocol  {

    private let loginService: LoginServiceProtocol
    private let coordinator: SplashViewCoordinator
    private var cancellables: [AnyCancellable?] = []

    init(loginService: LoginServiceProtocol,
         coordinator: SplashViewCoordinator) {
        self.loginService = loginService
        self.coordinator = coordinator
    }
    
    func attemptAutoLogin() {
        guard let autologinRequest = loginService.attemptAutologin() else {
            coordinator.showLogin()
            return
        }

        cancellables += [
            autologinRequest
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { [weak self] (completion) in
                    switch completion {
                    case .failure:
                        self?.coordinator.showLogin()
                    default:
                        return
                    }
                }, receiveValue: { [weak self] (success) in
                    if success {
                        self?.coordinator.showHome()
                    } else {
                        self?.coordinator.showLogin()
                    }
                })
        ]
    }
}
