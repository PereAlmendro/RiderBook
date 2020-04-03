//
//  ProfileRouter.swift
//  RiderBook
//
//  Created by Pere Almendro on 25/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

protocol ProfileRouter: BaseRouter { }

class ProfileRouterImpl: ProfileRouter {
    
    // MARK: - Properties
    
    var coordinator: AppCoordinator?
    
    // MARK: - Lifecycle
    
    required init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
}
