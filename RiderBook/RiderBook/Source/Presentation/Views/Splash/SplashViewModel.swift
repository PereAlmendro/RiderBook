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

    @Published var navigateHome: Bool = false
    @Published var navigateLogin: Bool = false

    private let loginService: LoginServiceProtocol
    private var cancellables: [AnyCancellable?] = []

    init(loginService: LoginServiceProtocol) {
        self.loginService = loginService
    }
    
    func attemptAutoLogin() {
        guard let autologinRequest = loginService.attemptAutologin() else {
            navigateLogin = true
            return
        }

        let autologinCancellable = autologinRequest
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] (completion) in
                switch completion {
                case .failure:
                    self?.navigateLogin = true
                default:
                    return
                }
            }, receiveValue: { [weak self] (success) in
                self?.navigateHome = true
            })

        cancellables.append(autologinCancellable)
    }
}
