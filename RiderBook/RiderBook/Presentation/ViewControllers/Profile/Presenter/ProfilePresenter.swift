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
    
    // MARK: - Lifecycle
    
    init(profileRouter: ProfileRouter) {
        self.profileRouter = profileRouter
    }
        
}
