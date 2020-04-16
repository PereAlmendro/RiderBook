//
//  LoginViewModel.swift
//  RiderBook
//
//  Created by Pere Almendro on 06/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import Combine
import RxSwift

protocol LoginViewModelProtocol: ObservableObject {
    
}

class LoginViewModel: LoginViewModelProtocol  {
    
    // MARK: - View properties
    var showLoading: Bool = false
    var screenTitle = "Rider_book"
    var disposeBag = DisposeBag()
    
    // MARK: - Private properties
    
    private var loginService: LoginServiceProtocol
    private var coordinator: AppCoordinatorProtocol
    
    init(loginService: LoginServiceProtocol, coordinator: AppCoordinatorProtocol) {
        self.loginService = loginService
        self.coordinator = coordinator
    }
}
