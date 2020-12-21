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

    @Published var navigation: Navigation? = nil
    enum Navigation {
        case home(title: String)
        case login
    }

    private let loginService: LoginServiceProtocol
    private var cancellables: [AnyCancellable?] = []

    init(loginService: LoginServiceProtocol) {
        self.loginService = loginService
    }
    
    func attemptAutoLogin() {
        guard let autologinRequest = loginService.attemptAutologin() else {
            navigation = .login
            return
        }

        let autologinCancellable = autologinRequest
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] (completion) in
                switch completion {
                case .failure:
                    self?.navigation = .login
                default:
                    return
                }
            }, receiveValue: { [weak self] (success) in
                self?.navigation = .home(title: "Hello pipol")
            })

        cancellables.append(autologinCancellable)
    }
}
