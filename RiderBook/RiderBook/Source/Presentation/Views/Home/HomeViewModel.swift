//
//  HomeViewModel.swift
//  RiderBook
//
//  Created by Pere Almendro on 17/05/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import Combine

protocol HomeViewModelProtocol: AnyObject {
    
}

final class HomeViewModel: ObservableObject, HomeViewModelProtocol  {

    // MARK: - Private properties
    
    private let coordinator: AppCoordinatorProtocol
    private var cancellables: [AnyCancellable?] = []
    
    // MARK: - Lifecycle
    
    init(coordinator: AppCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    // MARK: - User Actions
    
}
