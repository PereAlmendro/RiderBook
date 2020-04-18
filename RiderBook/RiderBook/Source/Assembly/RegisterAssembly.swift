//
//  RegisterAssembly.swift
//  RiderBook
//
//  Created by Pere Almendro on 18/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import UIKit

class RegisterAssembly {
    private let coordinator: AppCoordinatorProtocol
    
    init(coordinator: AppCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func getView() -> RegisterView {
        let riderBookApiService = RiderBookApiService()
        let userRepository = UserRepository(riderBookApiService: riderBookApiService)
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let localRepository = LocalRepository(context: context)
        let loginService = LoginService(userRepository: userRepository, localRepository: localRepository)
        let registerViewModel = RegisterViewModel(loginService: loginService, coordinator: coordinator)
        return RegisterView(viewModel: registerViewModel)
    }
}
