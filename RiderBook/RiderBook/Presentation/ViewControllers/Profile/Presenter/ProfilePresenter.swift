//
//  ProfilePresenter.swift
//  RiderBook
//
//  Created by Pere Almendro on 24/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

class ProfilePresenter: BasePresenter {
    
    // MARK: - Properties
    
    private let profileRouter: ProfileRouter
    private let profileInteractor: ProfileInteractor
    
    // MARK: - Lifecycle
    
    init(profileRouter: ProfileRouter, profileInteractor: ProfileInteractor) {
        self.profileRouter = profileRouter
        self.profileInteractor = profileInteractor
    }
        
}
