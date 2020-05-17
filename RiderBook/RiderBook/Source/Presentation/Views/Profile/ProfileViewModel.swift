//
//  ProfileViewModel.swift
//  RiderBook
//
//  Created by Pere Almendro on 15/05/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import Combine

protocol ProfileViewModelProtocol: AnyObject {
    
}

final class ProfileViewModel: ObservableObject, ProfileViewModelProtocol  {

    // MARK: - Private properties
    
    private let userService: UserServiceProtocol
    private let loginService: LoginServiceProtocol
    private let coordinator: AppCoordinatorProtocol
    private var cancellables: [AnyCancellable?] = []
    
    // MARK: - Lifecycle
    
    init(loginService: LoginServiceProtocol,
         userService: UserServiceProtocol,
         coordinator: AppCoordinatorProtocol) {
        self.loginService = loginService
        self.userService = userService
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
    
    func deleteAccountAction() {
        // TODO: - Delete account action
    }
    
    func uploadImageAction() {
        // TODO: - Upload image action
    }
}
