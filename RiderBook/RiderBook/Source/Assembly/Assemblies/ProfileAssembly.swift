//
//  ProfileAssembly.swift
//  RiderBook
//
//  Created by Pere Almendro on 11/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

class ProfileAssembly {
    private let coordinator: AppCoordinator
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }

    func getView() -> ProfileView {
        return ProfileView()
    }
}
