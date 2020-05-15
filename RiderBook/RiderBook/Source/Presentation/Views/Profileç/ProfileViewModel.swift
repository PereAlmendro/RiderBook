//
//  ProfileViewModel.swift
//  RiderBook
//
//  Created by Pere Almendro on 15/05/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import Combine

class ProfileViewModel: ObservableObject  {

    // MARK: - Private properties
    
    private let loginService: LoginServiceProtocol
    private let coordinator: AppCoordinatorProtocol
    private var cancellables: [AnyCancellable?] = []
    
    // MARK: - Lifecycle
    
    init(loginService: LoginServiceProtocol, coordinator: AppCoordinatorProtocol) {
        self.loginService = loginService
        self.coordinator = coordinator
    }
    
    // MARK: - User Actions
    
    func logoutAction() {
        if loginService.logOut() {
            coordinator.start()
        } else {
            // TODO: Logout failed
        }
    }
    
}
